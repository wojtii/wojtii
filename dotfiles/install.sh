#!/bin/bash
# based on https://chodounsky.com/2017/01/20/automate-your-macos-development-machine-setup/

# TODO ohmyzsh
# TODO doom emacs setup
# TODO iterm config

REPO_DIR=~/wojtii
DOTFILES_DIR=$REPO_DIR/dotfiles

xcode-select --install

# dotfiles
ln -s $DOTFILES_DIR/.gitconfig ~/.gitconfig
ln -s $DOTFILES_DIR/.vimrc ~/.vimrc
ln -s $DOTFILES_DIR/.zshrc ~/.zshrc

mkdir -p ~/.config
ln -s $DOTFILES_DIR/starship.toml ~/.config/starship.toml

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
cd ~/wojtii/dotfiles || exit 1
brew bundle
