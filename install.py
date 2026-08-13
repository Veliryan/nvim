import shutil
import platform
import subprocess

PACKAGES = {
        "nvim": {
            "pacman": "neovim",
            "dnf": "neovim",
            "apt": "neovim",
            "brew": "neovim",
            },
        "git": {
            "pacman": "git",
            "dnf": "git",
            "apt": "git",
            "brew": "git",
            },
        "luarocks": {
            "pacman": "luarocks",
            "dnf": "luarocks",
            "apt": "luarocks",
            "brew": "luarocks",
            },
        "rg": {
            "pacman": "ripgrep",
            "dnf": "ripgrep",
            "apt": "ripgrep",
            "brew": "ripgrep",
            },
        "fd": {
            "pacman": "fd",
            "dnf": "fd-find",
            "apt": "fd-find",
            "brew": "fd",
            },
        "curl": {
            "pacman": "curl",
            "dnf": "curl",
            "apt": "curl",
            "brew": "curl",
            },
        "gcc": {
            "pacman": "gcc",
            "dnf": "gcc",
            "apt": "gcc",
            "brew": "gcc",
            },
        "java": {
            "pacman": "jdk-openjdk",
            "dnf": "java-21-openjdk",
            "apt": "default-jdk",
            "brew": "openjdk",
            },
        "node": {
            "pacman": "nodejs",
            "dnf": "nodejs",
            "apt": "nodejs",
            "brew": "node",
            },
    "npm": {
            "pacman": "npm",
            "dnf": "npm",
            "apt": "npm",
            "brew": "npm",
            },
    "python3": {
            "pacman": "python",
            "dnf": "python3",
            "apt": "python3",
            "brew": "python",
            },
    "cargo": {
            "pacman": "rust",
            "dnf": "cargo",
            "apt": "cargo",
            "brew": "rust",
            },
}


def FindPackageManager():
    if platform.system() == "Darwin":
        if shutil.which("brew"):
            return "brew"
    elif platform.system() == "Linux":
        for manager in ("pacman", "dnf", "apt-get"):
            if shutil.which(manager):
                return manager

    return None


def FindMissingPackages(package_manager):
    missing = {}

    for executable, package_names in PACKAGES.items():
        if shutil.which(executable) is None:
            missing[executable] = package_names[package_manager]

    return missing

def install_packages(package_manager, missing):
    packages = list(missing.values())

    if not packages:
        return

    if package_manager == "pacman":
        command = ["sudo", "pacman", "-S", "--needed", *packages]

    elif package_manager == "dnf":
        command = ["sudo", "dnf", "install", "-y", *packages]

    elif package_manager == "apt":
        command = ["sudo", "apt", "install", "-y", *packages]

    elif package_manager == "brew":
        command = ["brew", "install", *packages]

    else:
        raise ValueError(f"Unsupported package manager: {package_manager}")

    subprocess.run(command, check=True)

def main():
    package_manager = FindPackageManager()
    if package_manager is None:
        raise RuntimeError("Unsupported System: No Supported Package Manager was found")

    print(f"Package Manager found: {package_manager}")
    print("Checking Packages: ")

    missing_packages = FindMissingPackages(package_manager)

    if len(missing_packages) > 0:
        print("Missing Packages Found:")
        for package in missing_packages:
            print(f"❌  {package}")
    else:
        print("No missing packages Found")
        return

    print("")
    answer = input("Would you like to install the Missing Packages?(y/n)")

    if answer == "y":
        print("Installing Packages:")
        install_packages(package_manager, missing_packages)
    else:
        return


if __name__ == "__main__":
    main()
