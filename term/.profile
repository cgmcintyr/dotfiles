# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

PATH_EXPORTS=(
	"$HOME/devel/go/bin"  # Golang
	"$HOME/.cabal/bin"  # Haskell
	"$HOME/.cargo/bin"  # Rust
	"$HOME/.local/anaconda3/bin" # Anaconda
	"$HOME/.local/bin"  # Local
	"$HOME/.poetry/bin"  # Python Poetry
	"$HOME/.rvm/bin"  # Ruby Version Manager
	"$HOME/bin"  # Home
)

BACKGROUND_COMMANDS=(
	"dunst"  # Notifications
	"redshift"  # Redlight colour adjustment
	"sxhkd"  # Simple X Hotkey Daemon
	"xscreensaver"  # Screensaver server process
	"fcitx" # Input methods
)



##
# Echo arguments that are not running commands.
#
# Arguments:
#   $@ = list of command names.
##
filter_command_not_running() {
	for command in "$@"; do
		if ! pgrep -x "$command" > /dev/null; then
			echo "$command"
		fi
	done
}


##
# Echo $PATH prepended with $1 if $1 is not in $PATH.
#
# Globals:
#   $PATH (no mutate)
# Arguments:
#   $1 = path to prepend to $PATH.
##
path_with() {
	if [[ ":$PATH:" != *":$1:"* ]]; then
		echo "${1}:${PATH}"
	else
		echo "$PATH"
	fi
}


##
# Echo arguments that are directories.
#
# Arguments:
#   $@ = array of paths to check for directories.
##
filter_is_directory() {
	for path in "$@"; do
		if [ -d "$path" ]; then
			echo "$path"
		fi
	done
}


##
# Ensure BACKGROUND_COMMANDS are running.
#
# Globals:
#   $BACKGROUND_COMMANDS (no mutate)
##
setup_background_commands() {
	filter_command_not_running "${BACKGROUND_COMMANDS[@]}"
	for command in $(filter_command_not_running "${BACKGROUND_COMMANDS[@]}"); do
		"${command[@]}" 2>/dev/null &
	done
}


##
# Delete contents of $HOME/Downloads
##
clear_downloads() {
	rm -rf $HOME/Downloads && mkdir $HOME/Downloads
}


##
# Configure pass password manager.
##
setup_pass() {
	export PASSWORD_STORE_DIR=/media/cgm/ENCRYPTED/.password-store
}


##
# Start gpg-agent
##
setup_gpg_agent() {
	# NB: After version 2.1 the gpu-agent-info file is no longer needed
	#     see https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
	if test "$( gpg-agent --version | head -n 1 | awk '{print $3, "\n2.1.0"}' | sort -V | head -n 1)" != "2.1.0"; then
		[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
		if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
			export GPG_AGENT_INFO
		else
		eval "$( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )"
		fi
	fi
}


##
# Set wallpaper using feh.
##
setup_wallpaper() {
	feh  -B "#062542"  --bg-center ~/Pictures/none.png
}


##
# Set default SHELL to zsh
##
setup_default_shell() {
	local zsh_path
	zsh_path="$(command -v zsh)"
	export SHELL="$zsh_path"
	export ZDOTDIR="$HOME/.config/zsh"
}


##
# Source .bashrc if we are in bash.
#
# Globals:
#   $BASH_VERSION (no mutate)
#   $HOME (no mutate)
##
setup_aliases() {
	if [ -f "$HOME/.aliases" ]; then
		source "$HOME/.aliases"
	fi
}

##
# Source user nix.sh if present.
#
# Globals:
#   $HOME (no mutate)
##
setup_nix() {
	if [[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]]; then
		source $HOME/.nix-profile/etc/profile.d/nix.sh;
	fi
}



##
# Ensure $PATH contains $PATH_EXPORTS.
#
# Globals:
#   $PATH (mutate)
#   $PATH_EXPORTS (no mutate)
##
setup_path() {
	for dir in $(filter_is_directory "${PATH_EXPORTS[@]}"); do
		PATH="$(PATH=$PATH path_with "$dir")"
	done
	export PATH="$PATH"
}


setup_fcitx() {
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx
}


main() {
	setup_path  # Needs to be called first

	# Shell
	setup_aliases
	setup_default_shell
	setup_nix

	# Desktop
	setup_wallpaper
	setup_gpg_agent
	setup_pass
	setup_background_commands

	# Other
	clear_downloads
}


main "$@"
