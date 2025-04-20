#!/bin/bash

# Enable dotglob to include hidden files (those starting with .)
shopt -s dotglob

# Get the absolute path of the current directory
current_dir="$(pwd)"

# Get the absolute path of the script
script_path="$(realpath "$0")"

# Define color codes
ORANGE='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

# Function to prompt for yes/no confirmation
prompt_yes_no() {
  local prompt_message="$1"
  local user_input
  while true; do
    echo  # Adds a blank line for spacing
    read -r -p "$(echo -e "${BOLD}${prompt_message} (y/n): ${RESET}")" user_input < /dev/tty
    case "$user_input" in
      [Yy]* ) return 0 ;;
      [Nn]* ) return 1 ;;
      * ) echo -e "Please answer y or n." ;;
    esac
  done
}

# Function to install Homebrew if not installed
install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo -e "Homebrew is not installed. Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH
    if [[ -d "/opt/homebrew/bin" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d "/usr/local/bin" ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    echo -e "Homebrew is already installed."
  fi
}

# Function to install Zsh if not installed
install_zsh() {
  if ! command -v zsh >/dev/null 2>&1; then
    echo -e "Zsh is not installed. Installing Zsh..."
    if command -v brew >/dev/null 2>&1; then
      brew install zsh
    elif command -v apt >/dev/null 2>&1; then
      sudo apt update && sudo apt install zsh -y
    elif command -v dnf >/dev/null 2>&1; then
      sudo dnf install zsh -y
    elif command -v yum >/dev/null 2>&1; then
      sudo yum install zsh -y
    elif command -v pacman >/dev/null 2>&1; then
      sudo pacman -Sy zsh --noconfirm
    elif command -v zypper >/dev/null 2>&1; then
      sudo zypper install zsh -y
    else
      echo -e "Unsupported package manager. Please install Zsh manually."
      exit 1
    fi
  else
    echo -e "Zsh is already installed."
  fi
}

# Function to install Oh My Zsh if not installed
install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "Oh My Zsh is not installed. Installing now..."
    # Install Oh My Zsh without changing the default shell and without running Zsh after installation
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Verify installation
    if [ -d "$HOME/.oh-my-zsh" ]; then
      echo -e "Oh My Zsh installation completed successfully."
    else
      echo -e "Oh My Zsh installation failed. Please check your internet connection and try again."
      exit 1
    fi
  else
    echo -e "Oh My Zsh is already installed."
  fi
}

# Install Homebrew, Zsh, and Oh My Zsh if necessary
install_homebrew
install_zsh
install_oh_my_zsh

# Check if the current directory is a Git repository
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  # Initialize an empty array for Git-ignored files
  git_ignored_files=()
  # Read each Git-ignored file into the array
  while IFS= read -r line; do
    git_ignored_files+=("$line")
  done < <(git ls-files --others --ignored --exclude-standard)
else
  git_ignored_files=()
fi

# Function to check if a file is in the list of Git-ignored files
is_git_ignored() {
  local file="$1"
  for ignored in "${git_ignored_files[@]}"; do
    if [[ "$file" == "$current_dir/$ignored" ]]; then
      return 0
    fi
  done
  return 1
}

# Iterate over all files in the current directory recursively
find "$current_dir" -type f | while IFS= read -r file; do
  # Skip the script itself
  [ "$(realpath "$file")" = "$script_path" ] && continue

  # Skip if the file is inside the .git directory
  [[ "$file" == "$current_dir/.git/"* ]] && continue

  # Skip if the file is ignored by Git
  is_git_ignored "$file" && continue

  # Extract the relative path of the file
  relative_path="${file#$current_dir/}"

  # Skip README.md
  [ "$relative_path" = "README.md" ] && continue

  # Define the target path in the home directory
  target="$HOME/$relative_path"

  # Check if the target already exists
  if [ -e "$target" ]; then
    echo -e "${ORANGE}Warning: $target already exists. Skipping.${RESET}"
    continue
  fi

  # Prompt the user for confirmation
  if prompt_yes_no "Do you want to symlink '$relative_path' to your home directory?"; then
    # Create the target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    ln -s "$file" "$target"
    echo -e "Linked $file → $target"
  else
    echo -e "Skipped $relative_path"
  fi
done


