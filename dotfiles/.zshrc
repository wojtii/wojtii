export ZSH="/Users/$USER/.oh-my-zsh"

plugins=(
  git
  osx
  colored-man-pages
  colorize
  zsh-syntax-highlighting
  zsh-autosuggestions
)

ZSH_DISABLE_COMPFIX="true" source $ZSH/oh-my-zsh.sh

alias v='vim'

export EDITOR='vim'
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
export GOPROXY=direct
export GOSUMDB=off

eval "$(pyenv init -)"

eval "$(starship init zsh)"
