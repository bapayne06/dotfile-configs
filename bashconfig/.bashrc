# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export HOME="/home/bpayne"

# Force on 256color, added by Brayden for scripting
export TERM=xterm-256color

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
#shopt -s globstar

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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)';
    PS1='${debian_chroot:+($debian_chroot)}\[\e[38;5;231;1m\][\[\e[38;5;220m\]\A\[\e[97m\]]\[\e[0m\] \[\e[38;5;196;1m\]${PS1_CMD1}\n\[\e[38;5;118m\]\u@\h:\[\e[0m\] \[\e[38;5;40;1m\]\w\[\e[0m\] \[\e[38;5;40m$ \[\e[0m\]'

else
    PS1='${debian_chroot:+($debian_chroot)}\t\n\u@\h:\w\$ '
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

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# if [ -f "$HOME/.bash_aliases" ]; then
# 	. "$HOME/.bash_aliases"
# fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export MANPAGER="/usr/bin/most -s"

set mark-symlinked-directories on

# Startup nnn file manager if installed 
if dpkg -s nnn &> /dev/null; then
	[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
	export NNN_TMPFILE='/tmp/.lastd'
	export NNN_PLUG='e:-xdgdefault;g:getplugs;m:mp3conv;r:rsynccp;s:organize'
# No clue what this does but ima keep it 
	# nnn_cd(){
	# 	if ! [ -z "$NNN_PIPE"  ]; then
	# 		printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
	# 	fi
	# }
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='nnn -de'
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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" 
"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' \

alias c='clear'

alias lsa='ls -a'
alias lsl='ls -l'

alias home='cd ~'
alias root='cd /'

alias gs='git status'

# nnn terminal file manager
alias nnn='nnn -H'
alias nf='nnn -H'
alias Nf='sudo nnn -H'
alias upn='sh -c $(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)'

# terminal package manager
alias Apt='aptitude'

# htop system monitor
alias ht='htop'


export EDITOR="usr/bin/gvim"
export VISUAL="usr/bin/gvim"


echo -e "\e[01;37mbash ${BASH_VERSION}\n\n\
'ht' for system monitor\n\
'nf' for file manager ('Nf' for sudo)\n\
'Apt' for package manager\e[0m\n"
