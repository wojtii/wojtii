source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/.fzf.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.zsh

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit
setopt globdots

 setopt share_history

bindkey -e

alias g='git'
alias v='nvim'
alias vz='v ~/.zshrc'
alias vv='v ~/.config/nvim/init.vim'
alias ls='exa'
alias ll='ls -la'
alias bb='brew bundle --file ~/.config/Brewfile'
alias docker-clear='docker kill $(docker ps -q) && docker rm $(docker ps -a -q)'

alias ~='cd ~'
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

export EDITOR='nvim'

export PATH=$PATH:$(go env GOPATH)/bin

eval "$(starship init zsh)"
