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

# Coloured man pages
alias man="LESS_TERMCAP_mb=$'\x1B[1;31m' \
            LESS_TERMCAP_md=$'\x1B[1;31m' \
            LESS_TERMCAP_me=$'\x1B[0m' \
            LESS_TERMCAP_se=$'\x1B[0m' \
            LESS_TERMCAP_so=$'\x1B[1;44;33m' \
            LESS_TERMCAP_ue=$'\x1B[0m' \
            LESS_TERMCAP_us=$'\x1B[1;32m' \
            man"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
