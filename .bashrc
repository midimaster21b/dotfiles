# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

##########################
# Begin My Customizations
##########################

# Include my bin directory
PATH="$HOME/bin:$PATH"

# pyenv variables and initiation
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_BIN_DIR="$PYENV_ROOT/bin"

if [[ -d "$PYENV_BIN_DIR" ]]; then
    export PATH="$PYENV_BIN_DIR:$PATH"
    eval "$(pyenv init -)"
fi

# Add rbenv shims to PATH
export PATH="$HOME/.rbenv/bin:$PATH"

# Enable rbenv autocomplete
eval "$(rbenv init -)"

# Disallows you to be spammed by the wall command
mesg n

# Make my default editor emacs
export EDITOR=emacs

# Always open emacs in no window mode!
alias emacs='emacs --no-window-system'

alias mx='tmux new -s'

alias cx='tmux attach -t'

alias lx='tmux list-sessions'

######################
# Begin PS1 Functions
######################

export QUOTES_FILE='.quotes'

# Echos quote for terminal title
get_quote() {
    # Get the number of lines in the quotes file
    QUOTE_LINES=`sed -n '$=' "$HOME/$QUOTES_FILE"`

    # Use modulus (%) and the $RANDOM environment variable to get a random line
    QUOTE_NUMBER=`expr $RANDOM % $QUOTE_LINES`

    # Shift the line number up, sed's line numbering is 1-indexed
    QUOTE_NUMBER=`expr $QUOTE_NUMBER + 1`

    # Echo the quote line
    echo `sed -n "$QUOTE_NUMBER{p;q}" "$HOME/$QUOTES_FILE"`
}

# Echo current pyenv virtualenv
currentworkingenv() {
    if $(pyenv local > /dev/null 2>&1)
    then
	echo "Python $(pyenv local)"
    elif $(rbenv local > /dev/null 2>&1)
    then
	echo "Ruby $(rbenv local)"
    elif $(env -i git status > /dev/null 2>&1)
    then
	 echo 'Git';
    elif $(env -i svn info > /dev/null 2>&1)
    then
	echo 'SVN';
    else
	echo '-'
    fi
}

# Echo current git repository name
currentrepo() {
    # env -i Ignores current environment
    # git status is a generic git command
    # > /dev/null push standard output to null
    # 2>&1 redirects standard error to null
    if $(env -i git status > /dev/null 2>&1)
    then
	for val in $(git remote -v | sed s/.*[/]//)
	do
    	    echo "$val";
	    break
	done
    elif $(env -i svn info > /dev/null 2>&1)
    then
	echo $(svn info --show-item wc-root | sed s/.*[/]//)
    else
    	echo "-"
    fi
}

# Echo current git branch name
currentbranch() {
    # env -i Ignores current environment
    # git status is a generic git command
    # > /dev/null push standard output to null
    # 2>&1 redirects standard error to null
    if $(env -i git status > /dev/null 2>&1)
    then
	echo $(git branch | grep "\*" | sed s/\*\ //)
    elif $(env -i svn info > /dev/null 2>&1)
    then
	echo $(svn info --show-item relative-url | awk -F "/" '{print $2}')
    else
    	echo "-"
    fi
}

####################
# End PS1 Functions
####################

# \u   = username
# \j   = jobs
# \W   = working directory
# \n   = newline
# \#   = command number
# \e[  = start of color prompt
# x;ym = foreground color code
# xm   = background color code
# \e[m = end of color prompt
# https://bbs.archlinux.org/viewtopic.php?id=103221
PS1='\[\e[0;36m\]\[\e[47m\] `currentworkingenv` | `currentrepo` | `currentbranch` | \w \[\e[m\]\[\e[m\]\n\[\e[0;31m\][\#]> \[\e[m\]'
PROMPT_COMMAND='echo -ne "\033]0;`get_quote`\007"'

########################
# End My Customizations
########################


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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


# GET RID OF OLD PS1
# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
