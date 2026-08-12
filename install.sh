#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# Neovim Development Environment Installer
#
# Supported:
#   - macOS
#   - Arch Linux
#   - Fedora
#   - Debian / Ubuntu
#
# Shell-independent:
#   - bash
#   - zsh
#   - fish
#
# Usage:
#   ./install.sh
# ============================================================

# ------------------------------------------------------------
# Colors / output
# ------------------------------------------------------------

if [[ -t 1 ]]; then
    BOLD='\033[1m'
    GREEN='\033[32m'
    YELLOW='\033[33m'
    RED='\033[31m'
    BLUE='\033[34m'
    RESET='\033[0m'
else
    BOLD=''
    GREEN=''
    YELLOW=''
    RED=''
    BLUE=''
    RESET=''
fi

info() {
    printf "${BLUE}==>${RESET} %s\n" "$1"
}

success() {
    printf "${GREEN}✓${RESET} %s\n" "$1"
}

warning() {
    printf "${YELLOW}!${RESET} %s\n" "$1"
}

error() {
    printf "${RED}✗${RESET} %s\n" "$1" >&2
}

die() {
    error "$1"
    exit 1
}

# ------------------------------------------------------------
# Root / sudo handling
# ------------------------------------------------------------

if [[ "${EUID}" -eq 0 ]]; then
    SUDO=""
else
    SUDO="sudo"
fi

run_as_root() {
    if [[ -n "$SUDO" ]]; then
        sudo "$@"
    else
        "$@"
    fi
}

# ------------------------------------------------------------
# OS detection
# ------------------------------------------------------------

OS=""
DISTRO=""

detect_os() {
    case "$(uname -s)" in
        Darwin)
            OS="macos"
            ;;

        Linux)
            OS="linux"

            if [[ ! -f /etc/os-release ]]; then
                die "Cannot determine Linux distribution."
            fi

            # shellcheck disable=SC1091
            source /etc/os-release

            case "${ID:-}" in
                arch)
                    DISTRO="arch"
                    ;;

                fedora)
                    DISTRO="fedora"
                    ;;

                debian)
                    DISTRO="debian"
                    ;;

                ubuntu)
                    DISTRO="debian"
                    ;;

                *)
                    die "Unsupported Linux distribution: ${ID:-unknown}"
                    ;;
            esac
            ;;

        *)
            die "Unsupported operating system: $(uname -s)"
            ;;
    esac
}

# ------------------------------------------------------------
# Package manager
# ------------------------------------------------------------

PACKAGE_MANAGER=""

detect_package_manager() {
    case "$OS" in
        macos)
            if command -v brew >/dev/null 2>&1; then
                PACKAGE_MANAGER="brew"
            else
                PACKAGE_MANAGER="brew"
            fi
            ;;

        linux)
            case "$DISTRO" in
                arch)
                    PACKAGE_MANAGER="pacman"
                    ;;

                fedora)
                    PACKAGE_MANAGER="dnf"
                    ;;

                debian)
                    PACKAGE_MANAGER="apt"
                    ;;
            esac
            ;;
    esac
}

# ------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------

install_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        success "Homebrew is already installed."
        return
    fi

    info "Homebrew is not installed."

    if [[ "$OS" == "macos" ]]; then
        info "Installing Homebrew..."
    else
        info "Installing Homebrew on Linux..."
    fi

    /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Try to make brew available immediately in this process.
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    command -v brew >/dev/null 2>&1 || \
        die "Homebrew was installed but could not be found in PATH."

    success "Homebrew installed."
}

# ------------------------------------------------------------
# Package installation helpers
# ------------------------------------------------------------

package_installed() {
    local package="$1"

    case "$PACKAGE_MANAGER" in
        brew)
            brew list --formula "$package" >/dev/null 2>&1
            ;;

        pacman)
            pacman -Q "$package" >/dev/null 2>&1
            ;;

        dnf)
            rpm -q "$package" >/dev/null 2>&1
            ;;

        apt)
            dpkg -s "$package" >/dev/null 2>&1
            ;;

        *)
            return 1
            ;;
    esac
}

install_packages() {
    local packages=("$@")
    local missing=()

    for package in "${packages[@]}"; do
        if package_installed "$package"; then
            success "$package is already installed."
        else
            missing+=("$package")
        fi
    done

    if [[ "${#missing[@]}" -eq 0 ]]; then
        return
    fi

    info "Installing: ${missing[*]}"

    case "$PACKAGE_MANAGER" in
        brew)
            brew install "${missing[@]}"
            ;;

        pacman)
            run_as_root pacman -S --needed --noconfirm "${missing[@]}"
            ;;

        dnf)
            run_as_root dnf install -y "${missing[@]}"
            ;;

        apt)
            run_as_root apt-get update
            run_as_root apt-get install -y "${missing[@]}"
            ;;

        *)
            die "Unknown package manager: $PACKAGE_MANAGER"
            ;;
    esac
}

# ------------------------------------------------------------
# System dependencies
# ------------------------------------------------------------

install_dependencies() {
    info "Installing system dependencies..."

    case "$OS" in

        macos)
            install_homebrew

            install_packages \
                neovim \
                git \
                luarocks \
                ripgrep \
                fd \
                curl \
                gcc \
                node \
                python
            ;;

        linux)
            case "$DISTRO" in

                arch)
                    install_packages \
                        neovim \
                        git \
                        luarocks \
                        ripgrep \
                        fd \
                        curl \
                        gcc \
                        nodejs \
                        npm \
                        python
                    ;;

                fedora)
                    install_packages \
                        neovim \
                        git \
                        luarocks \
                        ripgrep \
                        fd-find \
                        curl \
                        gcc \
                        gcc-c++ \
                        nodejs \
                        npm \
                        python3
                    ;;

                debian)
                    install_packages \
                        neovim \
                        git \
                        luarocks \
                        ripgrep \
                        fd-find \
                        curl \
                        gcc \
                        g++ \
                        nodejs \
                        npm \
                        python3
                    ;;
            esac
            ;;
    esac
}

# ------------------------------------------------------------
# Verify dependencies
# ------------------------------------------------------------

verify_command() {
    local command="$1"
    local description="$2"

    if command -v "$command" >/dev/null 2>&1; then
        success "$description: $(command -v "$command")"
    else
        warning "$description is not available."
    fi
}

verify_dependencies() {
    info "Checking installed tools..."

    verify_command nvim "Neovim"
    verify_command git "Git"
    verify_command luarocks "LuaRocks"
    verify_command rg "ripgrep"

    # Debian installs fd as fdfind.
    if command -v fd >/dev/null 2>&1; then
        success "fd: $(command -v fd)"
    elif command -v fdfind >/dev/null 2>&1; then
        success "fd: $(command -v fdfind)"
        warning "Debian provides fd as 'fdfind'."
        warning "You may want to create an 'fd' alias/symlink."
    else
        warning "fd is not available."
    fi

    verify_command curl "curl"
    verify_command gcc "GCC"
    verify_command node "Node.js"
    verify_command npm "npm"

    if command -v python3 >/dev/null 2>&1; then
        success "Python: $(command -v python3)"
    elif command -v python >/dev/null 2>&1; then
        success "Python: $(command -v python)"
    else
        warning "Python is not available."
    fi
}

# ------------------------------------------------------------
# Main
# ------------------------------------------------------------

main() {
    echo
    printf "${BOLD}Neovim Development Environment${RESET}\n"
    echo

    detect_os
    detect_package_manager

    info "Operating system: $OS"

    if [[ "$OS" == "linux" ]]; then
        info "Distribution: $DISTRO"
    fi

    info "Package manager: $PACKAGE_MANAGER"

    echo

    # macOS uses Homebrew.
    # Linux uses the native package manager.
    install_dependencies

    echo
    verify_dependencies

    echo
    success "Installation complete."
    echo

    if [[ "$OS" == "macos" ]]; then
        warning "If this was a fresh Homebrew installation, restart your shell or load brew's shellenv."
    fi

    echo
}

main "$@"
