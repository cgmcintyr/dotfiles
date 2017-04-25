# Setup oh-my-zsh
export ZSH=/home/cgmcintyre/.oh-my-zsh
ZSH_THEME="daveverwer"
plugins=(git)
source $ZSH/oh-my-zsh.sh

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
