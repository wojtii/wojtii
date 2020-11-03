 #!/bin/bash
 # based on https://chodounsky.com/2017/01/20/automate-your-macos-development-machine-setup/
 #
 # TODO ohmyzsh

 xcode-select --install

 # dotfiles
 # ln -s ~/wojtii/dotfiles/.bash_profile ~/.bash_profile

 # brew
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
 cd ~/wojtii/dotfiles || exit 1
 brew bundle
