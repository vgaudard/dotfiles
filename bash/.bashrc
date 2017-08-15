# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file
shopt -s histappend

# Bash  history size
HISTSIZE=1000
HISTFILESIZE=2000

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
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ -f ~/.bash_prompt_hide_host ]; then
    BASH_PROMPT_HIDE_HOST=yes
fi
if [ "$color_prompt" = yes ]; then
    set_prompt () {
        local lastCommand=$? # Must come first!
        local FancyX='\342\234\227'
        if [[ $EUID -ne 0 ]]; then  # if not root
            prompt_color="\[\e[1;33m\]"
            promt_symbol="$"
        else # if root
            prompt_color="\[\e[1;31m\]"
            promt_symbol="#"
        fi

        PS1=""
        # If last command failed, print a red X.
        if [[ $lastCommand != 0 ]]; then
            PS1+="\[\e[1;31m\]($lastCommand)"
        fi
        local d=$(date +"%H:%M:%S")
        #PS1="$PS1\[\e[0;33m\]{$d}" # Date and time
        PS1="$PS1$prompt_color(\u" # Username
        if [ "$BASH_PROMPT_HIDE_HOST" != yes ]; then
            PS1="$PS1@\h" # Host name
        fi
        PS1="$PS1\[$txtrst\]\[\e[1;34m\][\w]"  # Working directory

        if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) ]]; then # show git branch if in git subtree
            PS1="$PS1\[\e[0;30m\]>$(git rev-parse --abbrev-ref HEAD)\[\e[00m\]"
        fi

        PS1="$PS1$prompt_color) $promt_symbol\[\e[0m\] " # Prompt symbol

        local new_title=$(perl -p -e "s|^$HOME|~|;s|([^/])[^/]*/|$""1/|g" <<< $PWD)
        echo -ne "\033]2;$new_title\007"
    }
    PROMPT_COMMAND='set_prompt'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [  "$PS1"  ]
then
    echo -e "\e[1;36mLogged in as $USER on \e[4m$(tty)\e[0m"
    if [ -f /usr/games/fortune ]
    then
        echo -e "\e[0;36m$(/usr/games/fortune -n360 -s)\e[0m"
    fi
fi



if command -v todo > /dev/null 2>&1; then
    terminalName=$(basename /$(ps -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //'))
    if [ "$terminalName" != "yakuake" ] ; then
        todo
    fi
fi

export PATH=$PATH:~/bin
export CDPATH=.:..:~:/

if command -v setxkbmap > /dev/null 2>&1; then
    setxkbmap -option compose:rctrl
fi

export XCOMPOSEFILE=~/.XCompose

