# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's .local bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add cabal to PATH
if [ -d "$HOME/.cabal/bin" ] ; then
    export PATH="$PATH:$HOME/.cabal/bin"
fi

# Add RVM to PATH for scripting
if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi

# Add RVM to PATH for scripting
if [ -d "$HOME/devel/esp/esp-idf" ] ; then
    export IDF_PATH=$HOME/devel/esp/esp-idf
fi

# Add esp toolchain to PATH
if [ -d "$HOME/devel/esp/xtensa-esp32-elf/bin" ] ; then
    export PATH=$PATH:$HOME/devel/esp/xtensa-esp32-elf/bin
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [ -e "$HOME/.aliases" ] ; then
    source "$HOME/.aliases"
fi

# Load NVM into shell session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

 #Start gpg-agent 
# NB: After version 2.1 the gpu-agent-info file is no longer needed
#     see https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
if test "$( gpg-agent --version | head -n 1 | awk '{print $3, "\n2.1.0"}' | sort -V | head -n 1)" != "2.1.0"; then
  [ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
  if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
    export GPG_AGENT_INFO
  else
    eval $( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )
  fi
fi
