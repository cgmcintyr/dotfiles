# Setup oh-my-zsh
export ZSH=~/.oh-my-zsh
ZSH_THEME="daveverwer"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh

# Vi mode
export KEYTIMEOUT=1
bindkey '^[[Z' reverse-menu-complete

# Language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Python virtualenvwrapper
[ ! -d "$HOME/.virtualenvs" ] && mkdir "$HOME/.virtualenvs"
export WORKON_HOME="$HOME/.virtualenvs"
VENV="$(which virtualenvwrapper.sh)"
[[ ! -z $VENV ]] && source $VENV

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# rvm completion
fpath=(~/.zsh/Completion $fpath)

# Export GPG tty
GPG_TTY=$(tty)
export GPG_TTY

# Personal aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
