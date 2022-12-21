#!/bin/bash
# Automatic unattended setup for my nvim configuration
# Warning! This script will NOT ask before overwriting existing configuration.

# Backup existing configuration (if any)
echo "Backing up existing configuration..."
rm -rf ~/.config/nvim.old
mv ~/.config/nvim ~/.config/nvim.old
rm -rf ~/.local/share/nvim
echo "Existing configuration copied to ~/.config/nvim.old"

# Clone my nvim configuration:
echo "Cloning my nvim configuration..."
git clone git@github.com:mikebirdgeneau/nvim_config.git ~/.config/nvim

# Install packer.nvim:
echo "Installing packer.nvim..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install plugins using Packer:
echo "Installing plugins..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' > /dev/null 2>&1

echo "NeoVim configuration installed successfully!"
