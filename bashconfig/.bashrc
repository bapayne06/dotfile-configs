# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source /usr/share/autojump/autojump.sh

export HOME="/home/bpayne"

# Set 256-colour
export TERM=xterm-256color

# Sets default text editors
export EDITOR="nano"
export VISUAL="xed"

# Ensures that audio properly functions in Java-based applications
export NO_AT_BRIDGE=1

export STARSHIP_CONFIG=~/starship.toml

force_color_prompt=yes

# Colored man pages
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # Green
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # Green
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # Yellow
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput setaf 1) # Red Underline

export MANROFFOPT="-c"
export GROFF_NO_SGR=1
export MANPAGER="less -R"

# Anything below this block will only work in the terminal prompt,
# so anything else should be above this!
if [[ $- != *i* ]]; then
    return 2>/dev/null || exit 0
fi

#case $- in
#		*i*) ;;
#			*) return;;
#esac

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
	PS1='\[\033[1m\][\[\033[93m\]\t\[\033[39m\]]\n\[\033[92m\]\u\[\033[92m\]@\[\033[92m\]\h\[\033[39m\]:\[\033[97m\]\w\[\033[0m\] \[\033[92m\]\$\[\033[0m\] '
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
alias lsa='ls -a'
alias lsl='ls -l'

alias sc='source ~/.bashrc'

# Directory shortcuts
alias home='cd ~'
alias root='cd /'
alias hdd='cd /mnt/harddrive'

alias rmi='rm -rfI'

alias gs='git status'

alias hexedit='hexedit --color'

# spotify player for command line alias
# (github.com/aome510/spotify-player)
alias spotify='~/.cargo/bin/spotify_player'
