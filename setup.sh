#!/bin/bash

# Automatic setup for my nvim configuration

# Install requirements:
sudo dnf install neovim ripgrep

# Ask user if they want to delete their current nvim configuration
# if yes, delete it
# if no, exit
# if invalid input, ask again
read -p "Do you want to overwrite your nvim configuration? [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf ~/.config/nvim.old
    mv ~/.config/nvim ~/.config/nvim.old
    rm -rf ~/.local/share/nvim
    echo "Existing configuration copied to ~/.config/nvim.old"
else
    echo "Exiting..."
    exit 1
fi

# Clone my nvim configuration:
git clone git@github.com:mikebirdgeneau/nvim_config.git ~/.config/nvim

# Install packer.nvim:
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install plugins using Packer:
# This will open nvim and install all plugins
# Then it will close nvim
nvim -c "PackerSync" -c "qa"

echo "Done. Have fun!"
