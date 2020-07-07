#!/bin/bash

logger "Sourcing $HOME/.xinitrc"

# Source Fedora's common xinitrc commands
. /etc/X11/xinit/xinitrc-common

source $HOME/.profile
