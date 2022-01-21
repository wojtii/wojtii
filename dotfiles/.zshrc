source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias g='git'
alias v='nvim'
alias mfa='mfacli'
alias mfac='mfacli clipboard'
alias cl='clear'
alias gb="git branch --show-current"
alias vz='v ~/.zshrc'
alias vv='v ~/.config/nvim/init.vim'
alias ls='exa'
alias ll='ls -la'
alias mt='make test'

alias ~='cd ~'
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias docker-clear='docker kill $(docker ps -q) && docker rm $(docker ps -a -q)'

export EDITOR='nvim'

export GOPROXY=direct
export GOSUMDB=off
export PATH=$PATH:$(go env GOPATH)/bin

eval "$(starship init zsh)"

eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


zstyle ':completion:*' menu select # highlight current selection in completion
fpath=(~/.config/zsh/completion $fpath)
autoload -Uz compinit && compinit
