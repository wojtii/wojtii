#!/bin/bash
# based on
# https://chodounsky.com/2017/01/20/automate-your-macos-development-machine-setup/
# https://www.webpro.nl/articles/getting-started-with-dotfiles
# https://github.com/mathiasbynens/dotfiles

# WARNING: update system before running the script, TODO: automate this - `sudo softwareupdate -i -a` should be enough

# WARNING: before running verify if this is still recommended way of installing homebrew
# INFO: this should also install xcode
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# setup macos defaults:
./macos.sh

# WARNING this is going to install all from Brewfile, can take some time
brew bundle

DIR=~/priv/wojtii/dotfiles

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
# WARNING: after installing fzf, move `.fzf.zsh` file to $DIR/zsh and delete `.fzf.bash`, TODO: automate this
$(brew --prefix)/opt/fzf/install

# TODO: configs for other programs, like karabiner, rectangle etc.
