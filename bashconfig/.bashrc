# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source /usr/share/autojump/autojump.sh

export HOME="/home/bpayne"

# Set 256-colour 
export TERM=xterm-256color

# Sets default text editors for shell to use
export EDITOR="vim --nofork"
export VISUAL="gvim --nofork"

export HTOPRC="$HOME/.dotfiles/htop/htoprc" # Move default htop config path to this one

# Ensure gvim uses wayland
export GVIM_ENABLE_WAYLAND=1

force_color_prompt=yes

# If not running interactively, don't do anything
case $- in
		*i*) ;;
			*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=15000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
		debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
		xterm-color|*-256color) color_prompt=yes;;
esac


if [ -n "$force_color_prompt" ]; then
		if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
		else
	color_prompt=
		fi
fi

# Prompt shown after every command
if [ "$color_prompt" == 'yes' ]; then
	PS1='\[\e[1m\][\[\e[93m\]\t\[\e[39m\]]\n\[\e[92m\]\u\[\e[92m\]@\[\e[92m\]\h\[\e[39m\]:\[\e[97m\]\w\[\e[0m\] \[\e[92m\]\$\[\e[0m\] '
else # If no colour is on, this prompt will be displayed instead
	PS1='[\t]\n\u@\h:\w \$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
*)
		;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you dont need to enable
# this, if its already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Startup starship prompt for bash if installed
eval "$(starship init bash)"
eval "$(starship completions bash)"

set mark-symlinked-directories on

# Startup nnn file manager if installed
if dpkg -s nnn &> /dev/null; then
	[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
	export NNN_TMPFILE='/tmp/.lastd'
	export NNN_PLUG='e:-xdgdefault;g:getplugs;m:mp3conv;r:rsynccp;s:organize'
fi
alias nnn='nnn -H'
alias nf='nnn -H'
alias Nf='sudo nnn -H'
alias upn='sh -c $(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)'


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias sc='source ~/.bashrc'

alias lsa='ls -a'
alias lsl='ls -l'

alias home='cd ~'
alias root='cd /'

alias gs='git status'

# Display this message on terminal start
echo -e "\n\e[01;15mbash ${BASH_VERSION}\e[0m\n"
