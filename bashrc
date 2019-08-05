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
shopt -s autocd
shopt -s cdspell
shopt -s extglob

# feels good in emacs
stty -ixon


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# some more ls aliases
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

alias rscp='rsync -avPe ssh'
alias wtf='man'
alias bye='exit'
alias cd..='cd ..'
alias chicago='TZ=US/Central date'
alias taiwan='TZ=Asia/Taipei date'
# alias weather='curl wttr.in/Urbana,IL'
alias ta='tmux attach -d'
alias a='alsamixer'
alias gerp='grep'
alias gti='git'
alias gi='git'
alias gt='git'
alias open='xdg-open'
alias py='python'
alias ipy='ipython'
alias r='ranger'
alias u='urxvt'
alias uc='urxvtc'
alias vi='vim'
alias vd='vimdiff'
alias ivm='vim'
alias vmi='vim'
# pip install pyyaml
alias y2j='python3 -c "import yaml,sys,json; print json.dump(yaml.safe_load(sys.stdin), sys.stdout)"'

# lazy cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."


# Environment variables
export PERL5LIB=$HOME/perl5/lib/perl5/

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# vim rocks
export EDITOR=vim

export LESS="-R"

export GOPATH=$HOME/go
export PATH=$HOME/bin:$HOME/go/bin:$PATH

# load a key to ssh agent
# eval `ssh-agent`
# ssh-add ~/.ssh/<key to be added>

# use brew apps and GNU coreutils on OS X
if [ "$(uname)" == "Darwin" ] ; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH
fi

# git completion
# Archlinux from /usr/share/git/completion/
if [ -d /usr/share/git/completion/ ] ; then
  . /usr/share/git/completion/git-completion.bash
  . /usr/share/git/completion/git-prompt.sh
fi

# OS X from /usr/local/etc/bash_completion.d/
if [ -d /usr/local/etc/bash_completion.d/ ] ; then
  export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
  source "/usr/local/share/bash-completion/bash_completion"
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWCOLORHINTS=1

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
STR_HOST=$(hostname)
CHECKSUM=0
while test -n "$STR_HOST"; do
   CHAR=${STR_HOST:0:1}
   N=$(printf "%d" "'$CHAR")
   CHECKSUM=$(expr $CHECKSUM + "$N")
   STR_HOST=${STR_HOST:1}
done

# pick a color from set by checksum
SELECTIONS=${#HOST_COLORS[@]}
HOST_COLOR=${HOST_COLORS[$((CHECKSUM % SELECTIONS))]}

# my bash prompt
PS1='┌─'$COLOR_L_BLUE'[ \d-\t ]'$COLOR_END           # date
PS1+=$COLOR_YELLOW' \u '$COLOR_END                     # user
PS1+=$COLOR_L_BLACK'@'$COLOR_END                       # @
PS1+=$HOST_COLOR' \h '$COLOR_END                       # host
PS1+='$(ret_code)'$COLOR_END                           # return code
PS1+='$(__git_ps1 "[ ~> on %s ]")'                     # git info
PS1+=$COLOR_L_BLACK'$(svn_info)'$COLOR_END             # svn info
PS1+='\n'                                              # new line
PS1+='└─'$COLOR_L_CYAN'[\w]'$COLOR_END               # work directory
PS1+='-'$COLOR_PURPLE'[$(distro_name)] \$ '$COLOR_END  # distrobution name



# df check every day!
#perl $HOME/bin/dfCheckEveryday.pl
cal -3
#fortune




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

# show svn info
svn_info () {
    svn info 2>&1 | grep URL
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

qr () {
    qrencode $1 -o /tmp/qr.png && eog /tmp/qr.png
}

# convert unix timestamp (epoch) to date
unixtime() {
    date -d "@$1"
}

# python hacks
style-check() {
    # pip install yapf
    . $HOME/work/pip/bin/activate
    local style='{dedent_closing_brackets: true, split_before_logical_operator: false, split_complex_comprehension: true}'
    yapf --style="$style" "$1"
    deactivate
}

style-diff() {
    vimdiff -c 'set syntax=python' <(style-check "$1") "$1"
}

black-check() {
    # pip install black
    . $HOME/work/pip/bin/activate
    black --diff "$1"
    deactivate
}

pep8-check() {
    # pip install flake8 flake8-bugbear flake8-comprehensions flake8-docstrings flake8-import-order pep8-naming
    . $HOME/work/pip/bin/activate
    flake8 --ignore C408,D1 --show-source --import-order-style=google "$1"
    deactivate
}

pylint-check() {
    # pip install pylint
    . $HOME/work/pip/bin/activate
    pylint "$1"
    deactivate
}

upgrade-pips() {
    command -v pip
    pip install -r <(pip freeze | sed 's/==/>=/') --upgrade
}

wormhole-setup() {
    # quickly setup a magic-wormhole
    # https://github.com/warner/magic-wormhole
    # https://magic-wormhole.readthedocs.io/en/latest/welcome.html

    local venv_name
    venv_name="$(mktemp -u)"
    python3 -m venv "$venv_name"
    . "$venv_name/bin/activate"
    pip install --upgrade magic-wormhole pip
    echo "Activating venv: $VIRTUAL_ENV"
    echo "Usage: \$ wormhole send <filename>"
}

wormhole-kill() {
    local venv_name
    venv_name="$VIRTUAL_ENV"
    # delete magic-wormhole venv
    deactivate
    rm -rf "$venv_name"
}

screenshot() {
    # https://github.com/lupoDharkael/flameshot
    flameshot gui -d 3000
}
