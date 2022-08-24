#!/bin/bash
# based on https://chodounsky.com/2017/01/20/automate-your-macos-development-machine-setup/

# TODO first install brew

DIR=~/dev/wojtii/dotfiles

# dotfiles
ln -s $DIR/.gitconfig ~/.gitconfig
ln -s $DIR/.zshrc ~/.zshrc
ln -s $DIR/.ideavimrc ~/.ideavimrc

mkdir ~/.config
ln -s $DIR/starship.toml ~/.config/starship.toml
mkdir ~/.config/nvim
ln -s $DIR/init.vim  ~/.config/nvim/init.vim

mkdir ~/.config/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ~/.config/zsh/fzf-tab
$(brew --prefix)/opt/fzf/install
