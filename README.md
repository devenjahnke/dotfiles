# Dotfiles
This repository is responsible for defining and installing my preferred dotfiles.

To install the dotfiles, simply clone the repository to your device. Then, run the following commands:
1. `chmod +x install.sh`
2. `./install.sh`
3. `source ~/.zshrc`

The install script will perform the following:
1. Install Homebrew if it is not already installed.
2. Install ZSH if it is not already installed.
3. Install OhMyZSH if it is not already installed.
4. Symlink each of the dotfiles to the current user's home directory.
