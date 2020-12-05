#!/bin/bash
####################
# Use this script to create symlinks from the home directory to the specified dotfiles in the repository
####################

########## Variables

# Path to dotfiles repository directory
repo_dir="$PWD"

# Path to dotfiles backup directory
backup_dir="dotfiles_old"

# Dotfiles to be symlinked and backed up
files="bashrc gitconfig vimrc"

##########

# Create backup folder in home directory
echo -n "Creating $backup_dir directory to backup existing system dotfiles in home directory..."
cd ~
mkdir -p $backup_dir
echo "Existing dotfiles backed up."

# Change to the dotfiles repository directory
echo -n "Changing to the $repo_dir directory..."
cd $repo_dir
echo "Changed directories."

# Move exisiting dotfiles to backup directory and symlink repository dotfiles to home directory
for file in $files; do
	echo "Backing up existing .$file dotfile in the home directory to $backup_dir directory."
	mv ~/.$file ~/dotfiles_old/
	echo "Creating symlink in home directory to $file in dotfile repository."
	ln -s $repo_dir/$file ~/.$file
done
