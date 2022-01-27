source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/.fzf.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.zsh

fpath=(~/.config/zsh/completion $fpath)
autoload -Uz compinit && compinit
setopt globdots

bindkey -e

alias g='git'
alias v='nvim'
alias mfa='mfacli'
alias mfac='mfacli clipboard'
alias c='clear'
alias vz='v ~/.zshrc'
alias vv='v ~/.config/nvim/init.vim'
alias ls='exa'
alias ll='ls -la'
alias mt='make test'
alias go-lint-fix='golangci-lint run --new-from-rev=master --fix'

alias ~='cd ~'
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias docker-clear='docker kill $(docker ps -q) && docker rm $(docker ps -a -q)'
alias ctl='lima nerdctl'
alias ctl-clear='ctl kill $(ctl ps -q) && ctl rm $(ctl ps -a -q)'

export DOCKER_HOST=unix:///Users/$USER/.lima/docker/sock/docker.sock

export EDITOR='nvim'

export GOPROXY=direct
export GOSUMDB=off
export PATH=$PATH:$(go env GOPATH)/bin

eval "$(starship init zsh)"

eval "$(pyenv init -)"

