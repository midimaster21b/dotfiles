# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

ec() { emacsclient "$@" & }


# Compiles then opens README.pdf
# Optional argument: the directory containing the document
DOCS() {
    if [ -e README.rst ]
    then
	rst2pdf README.rst;
	xdg-open README.pdf;
    elif [ -e $1 ] && [ $# -eq 1 ]
    then
	rst2pdf "$1/README.rst";
	xdg-open "$1/README.pdf";
    else
	echo "README.rst not found."
    fi
}

# Compiles then opens DevGuide.pdf
# Optional argument: the directory containing the document
DEVDOCS() {
    if [ -e DevGuide.rst ]
    then
	rst2pdf DevGuide.rst;
	xdg-open DevGuide.pdf;
    elif [ -e $1 ] && [ $# -eq 1 ]
    then
	rst2pdf "$1/DevGuide.rst";
	xdg-open "$1/DevGuide.pdf";
    else
	echo "DevGuide.rst not found."
    fi
}

# Echo current git repository name
currentgitrepo() {
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
    else
    	echo "No Repository."
    fi
}

# Echo current git branch name
currentgitbranch() {
    # env -i Ignores current environment
    # git status is a generic git command
    # > /dev/null push standard output to null
    # 2>&1 redirects standard error to null
    if $(env -i git status > /dev/null 2>&1)
    then
	echo $(git branch | grep "\*" | sed s/\*\ //)
    else
    	echo "No branch."
    fi
}

currentdirectorysize() {
    for val in $(du -hcs | grep "total")
    do
	echo "$val"
	break
    done
}

# pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

# Disallows you to be spammed by the wall command
mesg n

# Make my default editor vim
export EDITOR=emacs

# Hide compiled python
alias ls='ls --hide=*.pyc'

# Always open emacs in no window mode!
alias emacs='emacs --no-window-system'

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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Add ~/bin to PATH variable
export PATH=~/bin:~/.local/bin:$PATH

# Initiate virtual environment
source virtualenvwrapper.sh

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

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi

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
PS1='\[\e[0;36m\]\[\e[47m\] `currentgitrepo` | `currentgitbranch` | \w \[\e[m\]\[\e[m\]\n\[\e[0;31m\][\#]> \[\e[m\]'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
