os.execute("clear")

print("Install Script for github.com/Veliryan/nvim starting ...")

local package_managers = { "pacman", "dnf", "apt-get", "brew" }
local manager = ""

local packages = {
  pacman = {
    { package = "neovim",      command = "nvim" },
    { package = "git",         command = "git" },
    { package = "ripgrep",     command = "rg" },
    { package = "fd",          command = "fd" },
    { package = "tar",         command = "tar" },
    { package = "curl",        command = "curl" },
    { package = "tree-sitter", command = "tree-sitter" },
    { package = "gcc",         command = "gcc" },
    { package = "npm",         command = "npm" },
    { package = "zip",         command = "zip" },
    { package = "unzip",       command = "unzip" },
  },

  dnf = {
    { package = "neovim",          command = "nvim" },
    { package = "git",             command = "git" },
    { package = "ripgrep",         command = "rg" },
    { package = "fd-find",         command = "fd" },
    { package = "tar",             command = "tar" },
    { package = "curl",            command = "curl" },
    { package = "tree-sitter-cli", command = "tree-sitter" },
    { package = "gcc",             command = "gcc" },
    { package = "npm",             command = "npm" },
    { package = "zip",             command = "zip" },
    { package = "unzip",           command = "unzip" },
  },

  ["apt-get"] = {
    { package = "neovim",          command = "nvim" },
    { package = "git",             command = "git" },
    { package = "ripgrep",         command = "rg" },
    { package = "fd-find",         command = "fdfind" },
    { package = "tar",             command = "tar" },
    { package = "curl",            command = "curl" },
    { package = "tree-sitter-cli", command = "tree-sitter" },
    { package = "gcc",             command = "gcc" },
    { package = "npm",             command = "npm" },
    { package = "zip",             command = "zip" },
    { package = "unzip",           command = "unzip" },
  },

  brew = {
    { package = "neovim",          command = "nvim" },
    { package = "git",             command = "git" },
    { package = "ripgrep",         command = "rg" },
    { package = "fd",              command = "fd" },
    { package = "gnu-tar",         command = "tar" },
    { package = "curl",            command = "curl" },
    { package = "tree-sitter-cli", command = "tree-sitter" },
    { package = "gcc",             command = "gcc" },
    { package = "node",            command = "npm" },
    { package = "zip",             command = "zip" },
    { package = "unzip",           command = "unzip" },
  },
}

local missing_packages = {}

local function is_installed(command)
  local result = os.execute("command -v " .. command .. " > /dev/null 2>&1")
  return result == true or result == 0
end

-- Find package manager
for _, mgr in ipairs(package_managers) do
  if is_installed(mgr) then
    manager = mgr
    break
  end
end

if manager == "" then
  print("No supported package manager found.")
  return
end

print("Package manager: " .. manager)
print("")

-- Find missing packages
for _, pkg in ipairs(packages[manager]) do
  if not is_installed(pkg.command) then
    table.insert(missing_packages, pkg)
  end
end

-- Everything already installed
if #missing_packages == 0 then
  print("✅ Everything is already installed ^^")
  return
end

print("Missing packages found:")
for _, pkg in ipairs(missing_packages) do
  print("❌ " .. pkg.package)
end

print("")

-- Build install command
local command = "sudo " .. manager

if manager == "pacman" then
  command = command .. " -S --needed "
elseif manager == "dnf" then
  command = command .. " install "
elseif manager == "apt-get" then
  command = command .. " install "
elseif manager == "brew" then
  command = "brew install "
end

local package_names = {}

for _, pkg in ipairs(missing_packages) do
  table.insert(package_names, pkg.package)
end

command = command .. table.concat(package_names, " ")

print("Running:")
print(command)
print("")

local result = os.execute(command)

if result ~= true and result ~= 0 then
  print("❌ Installation failed.")
  return
end

print("")
print("Checking installation...")

for _, pkg in ipairs(packages[manager]) do
  if is_installed(pkg.command) then
    print("✅ " .. pkg.command)
  else
    print("❌ " .. pkg.command)
  end
end
