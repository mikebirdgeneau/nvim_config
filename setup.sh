#!/bin/bash
#1
#

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
echo "Cloning my nvim configuration..."
git clone git@github.com:mikebirdgeneau/nvim_config.git ~/.config/nvim > /dev/null 2>&1

# Install packer.nvim:
echo "Installing packer.nvim..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim > /dev/null 2>&1

# Install plugins using Packer:
echo "Installing plugins..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' > /dev/null 2>&1

echo "Done. Have fun!"
