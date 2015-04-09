# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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


shopt -s autocd
shopt -s cdspell
shopt -s extglob

# feels good in emacs
stty -ixon


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
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

alias rscp='rsync -avPe ssh'
alias bbs='luit -encoding big5 telnet'

alias wtf='man'
alias bye='exit'
alias cd..='cd ..'
alias ta='tmux attach -d'
alias a='alsamixer'
alias greprn='grep -rn'
alias greprni='grep -rni'
alias greprin='grep -rin'
alias gerp='grep'
alias gerprn='grep -rn'
alias gerprni='grep -rni'
alias gerprin='grep -rin'
alias gti='git'
alias gi='git'
alias gt='git'
alias o='xdg-open'
alias open='xdg-open'
alias r='ranger'
alias u='urxvt'
alias uc='urxvtc'
alias vi='vim'
alias vd='vimdiff'
alias ivm='vim'
alias vmi='vim'

# lazy cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# we love UTF-8 environment!
#export LANG=zh_TW.UTF-8
#export LC_CTYPE=zh_TW.UTF-8
#export LC_ALL=zh_TW.UTF-8

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# vim rocks
export EDITOR=vim


export LESS="-R"
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# from /usr/share/git/completion/
. ~/.git-prompt.sh
. ~/.git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="branch"

# completion for ssh hosts
complete -W "$(echo $(grep '^ssh ' $HOME/.bash_history | sort -u | sed 's/^ssh //'))" ssh

# completion ignore the prefix 'sudo'
complete -cf sudo
complete -cf man
complete -cf proxychains

# search history using up/down keys
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\C-p":history-search-backward'
bind '"\C-n":history-search-forward'


# color definition
COLOR_END='\[\e[m\]'
COLOR_BLACK='\[\e[0;30m\]'
COLOR_RED='\[\e[0;31m\]'
COLOR_GREEN='\[\e[0;32m\]'
COLOR_YELLOW='\[\e[0;33m\]'
COLOR_BLUE='\[\e[0;34m\]'
COLOR_PURPLE='\[\e[0;35m\]'
COLOR_CYAN='\[\e[0;36m\]'
COLOR_WHITE='\[\e[0;37m\]'
COLOR_L_BLACK='\[\e[1;30m\]'
COLOR_L_RED='\[\e[1;31m\]'
COLOR_L_GREEN='\[\e[1;32m\]'
COLOR_L_YELLOW='\[\e[1;33m\]'
COLOR_L_BLUE='\[\e[1;34m\]'
COLOR_L_PURPLE='\[\e[1;35m\]'
COLOR_L_CYAN='\[\e[1;36m\]'
COLOR_L_WHITE='\[\e[1;37m\]'

# color set for hostname highlighting
# it's better to choose colors that looks different
HOST_COLORS=("$COLOR_L_CYAN"   \
             "$COLOR_L_RED"    \
             "$COLOR_L_GREEN"  \
             "$COLOR_L_YELLOW" \
             "$COLOR_L_PURPLE" )

# generate checksum from host name
STR_HOST=`hostname`
CHECKSUM=0
while test -n "$STR_HOST"; do
   CHAR=${STR_HOST:0:1}
   N=`printf "%d" "'$CHAR"`
   CHECKSUM=`expr $CHECKSUM + $N`
   STR_HOST=${STR_HOST:1}
done

# pick a color from set by checksum
SELECTIONS=${#HOST_COLORS[@]}
HOST_COLOR=${HOST_COLORS[$(($CHECKSUM % $SELECTIONS))]}

# my bash prompt
PS1='┌─'$COLOR_L_BLUE'[ \d-\t ]'$COLOR_END           # date
PS1+=$COLOR_YELLOW' \u '$COLOR_END                     # user
PS1+=$COLOR_L_BLACK'@'$COLOR_END                       # @
PS1+=$HOST_COLOR' \h '$COLOR_END                       # host
PS1+='$(ret_code)'                                     # return code
PS1+=$COLOR_L_PURPLE'$(__git_ps1 "[ ~> on %s ]")'$COLOR_END
                                                       # git info
PS1+='\n'                                              # new line
PS1+='└─'$COLOR_L_CYAN'[\w]'$COLOR_END               # work directory
PS1+='-'$COLOR_PURPLE'[$(distro_name)] \$ '$COLOR_END  # distrobution name



# df check every day!
#perl $HOME/bin/dfCheckEveryday.pl
cal -3
#fortune


PATH=$PATH:/home/xatier/bin


# display return code of previous command
ret_code () {
    ret=$?
    if [ $ret = 0 ]; then
        echo "^_^ "
    else
        echo "@_@ $ret "
    fi
}


# show distrobution name
distro_name () {
    cat /etc/*release | grep ^NAME= | cut -c6- | sed 's/\"//g'
}


# colorize man pages
man () {
    env LESS_TERMCAP_mb=$'\E[1;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[0;7;32m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[0;33m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    man "$@"
}

cppman () {
    env LESS_TERMCAP_mb=$'\E[1;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[0;7;32m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[0;33m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    cppman "$@"
}
