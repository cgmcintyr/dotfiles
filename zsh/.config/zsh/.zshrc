#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^R' history-incremental-pattern-search-backward

# Fzf
source $ZDOTDIR/.fzf
source /home/cgm/.aliases

# ShonenJump
source $ZDOTDIR/.shonenjump.zsh

# Language environment
export LANG=en_GB.UTF-8

# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vi'
   export VISUAL='vi'
else
   export EDITOR='nvim'
   export VISUAL='nvim'
fi

# Python virtualenvwrapper
[ ! -d "$HOME/.virtualenvs" ] && mkdir "$HOME/.virtualenvs"
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME="$HOME/.virtualenvs"
VENV="$(which virtualenvwrapper.sh)"
[[ ! -z $VENV ]] && source $VENV

# GO
if [ -d "$HOME/devel/go" ]; then
	export GOPATH="$HOME/devel/go"
	export GOROOT="$(asdf where golang $(asdf current golang))/go"
else
	mkdir "$HOME/devel/go"
	export GOPATH="$HOME/devel/go"
	export GOROOT="$(asdf where golang $(asdf current golang))/go"
fi

# Teg
#. ~/.local/teg-complete.sh

# GPG
GPG_TTY=$(tty)
export GPG_TTY

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
