export ZSH="/Users/$USER/.oh-my-zsh"

plugins=(
  git
  osx
  colored-man-pages
  colorize
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

source ~/.env

alias v='nvim'
alias mfa='mfacli'
alias mfac='mfacli clipboard'
alias python='python3.9'
alias pip='pip3.9'
alias cl='clear'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias gb="git branch --show-current"
alias vz='v ~/.zshrc'
alias vv='v ~/.config/nvim/init.vim'
alias l='exa -l -a'

alias docker-clear='docker kill $(docker ps -q) && docker rm $(docker ps -a -q)'
alias podman-clear='podman pod rm -fa && podman container rm -fa'
# podman issues on macos (good help - https://my.center-of.info/migrate-from-docker-to-podman-on-mac-os)
# 1. had to download additional podman-compose (docker has `docker compose`)
# 2. had to `rm ~/.docker/config.json` because of error in parsing auth header
# 3. had to change image names in `docker-compose.yml` to full names, e.g.
#    from `redis:6` to `docker.io/library/redis:6`
# 4. port forwarding not working - currently no solution

export EDITOR='nvim'
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
export GOPROXY=direct
export GOSUMDB=off
export PYENV_ROOT=$(pyenv root)

eval "$(pyenv init -)"

eval "$(starship init zsh)"

export PATH="/usr/local/opt/node@16/bin:$PATH"

