# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# Shell history settings
HISTCONTROL=erasedups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histreedit

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500000
HISTFILESIZE=500000

# Bash shell options
shopt -s autocd
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s extglob
shopt -s lithist

# feels good in emacs
stty -ixon

# GPG tty
# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
GPG_TTY=$(tty)
export GPG_TTY

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# some more ls aliases
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -AlFh'

alias a='alsamixer'
alias black='black --line-length 80'
alias bye='exit'
alias cd..='cd ..'
alias copy='xclip -selection clipboard'
alias d='deactivate'
alias delta='delta -sn'
alias edge='/usr/bin/microsoft-edge-dev &'
alias gerp='grep'
alias gi='git'
alias gt='git'
alias gti='git'
alias ipy='ipython'
alias ivm='vim'
alias j='sudachi'
alias jj='jagger'
alias open='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias py='python'
alias r='ranger'
alias rscp='rsync -avzzPhe ssh'
alias ta='tmux attach -d'
alias taiwan='TZ=Asia/Taipei date'
alias type='type -a'
alias u='urxvt'
alias uc='urxvtc'
alias urldecode='python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.stdin.read()))"'
alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()))"'
alias v='vim'
alias vd='vimdiff'
alias vi='vim'
alias vmi='vim'
alias vos='vim-open-search'
alias vso='vim-open-search'
alias wtf='man'
# pip install pyyaml
alias y2j='python3 -c "import yaml,sys,json; print json.dump(yaml.safe_load(sys.stdin), sys.stdout)"'

# lazy cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Environment variables
# Perl libraries
export PERL5LIB="$HOME/perl5/lib/perl5/"

# python startup
export PYTHONSTARTUP="$HOME/.pythonrc.py"

# locale environment variables
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# vim rocks
export EDITOR=vim

# for xdg-open
export BROWSER="/usr/bin/microsoft-edge-dev"

[[ -x /usr/bin/lesspipe.sh ]] && eval "$(SHELL=/bin/sh lesspipe.sh)"
export LESS="-R"

export GOPATH="$HOME/go"
export PATH="$HOME/bin:$HOME/go/bin:$PATH"

# override VA-API driver with vdpau
# https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuring_VA-API
export LIBVA_DRIVER_NAME=vdpau

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

# load rg config
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/rc

# load ag completion file
if [[ -d /usr/share/the_silver_searcher/ ]]; then
    source /usr/share/the_silver_searcher/completions/ag.bashcomp.sh
fi

# load a key to ssh agent
# eval `ssh-agent`
# ssh-add ~/.ssh/<key to be added>

# use brew apps and GNU coreutils on OS X
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:"$PATH"
    BREW_PREFIX="$(brew --prefix)"
fi

# git completion
# Archlinux from /usr/share/git/completion/
if [[ -d /usr/share/git/completion/ ]]; then
    source /usr/share/git/completion/git-completion.bash
    source /usr/share/git/completion/git-prompt.sh
fi

# OS X from ${BREW_PREFIX}/etc/bash_completion.d/
if [[ -n "$BREW_PREFIX" && -d "$BREW_PREFIX/etc/bash_completion.d/" ]]; then
    export BASH_COMPLETION_COMPAT_DIR="$BREW_PREFIX/etc/bash_completion.d"
    source "$BREW_PREFIX/share/bash-completion/bash_completion"
fi

# GIT_PS1 controls, used in __git_ps1 below
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWCOLORHINTS=1

# completion ignore the prefix 'sudo'
complete -cf sudo

# fzf completion and bindings
if [[ -x /usr/bin/fzf ]]; then
    eval "$(fzf --bash)"
fi
if [[ -n "$BREW_PREFIX" && -d "$BREW_PREFIX/opt/fzf/" ]]; then
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.bash"
    source "$BREW_PREFIX/opt/fzf/shell/completion.bash"
fi
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='
--border
--border-label="／人◕ ‿‿ ◕人＼ ~(￣▽￣)~(＿△＿)~(￣▽￣)~(＿△＿)~(￣▽￣)~ ／人◕ ‿‿ ◕人＼"
--cycle
--header="(∩ ◕_▩ )⊃━☆ﾟExplosion！"
--layout=reverse
--multi
--pointer="つ"
--prompt="(´・ω・`) "
'

if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
    source /usr/share/nvm/init-nvm.sh
fi

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
HOST_COLORS=("$COLOR_L_CYAN"
    "$COLOR_L_RED"
    "$COLOR_L_GREEN"
    "$COLOR_L_YELLOW"
    "$COLOR_L_PURPLE")

# generate checksum from host name
STR_HOST=$(hostname)
CHECKSUM=0
while [[ -n "$STR_HOST" ]]; do
    CHAR=${STR_HOST:0:1}
    N=$(printf "%d" "'$CHAR")
    CHECKSUM=$(("$CHECKSUM" + "$N"))
    STR_HOST=${STR_HOST:1}
done

# pick a color from set by checksum
SELECTIONS=${#HOST_COLORS[@]}
HOST_COLOR=${HOST_COLORS[$((CHECKSUM % SELECTIONS))]}

# my bash prompt
PS1='┌─'$COLOR_L_BLUE'[ \d-\t ]'$COLOR_END            # date
PS1+=$COLOR_YELLOW' \u '$COLOR_END                    # user
PS1+=$COLOR_L_BLACK'@'$COLOR_END                      # @
PS1+=$HOST_COLOR' \h '$COLOR_END                      # host
PS1+='$(ret_code)'$COLOR_END                          # return code
PS1+='$(git_origin_url)'                              # display git origin
PS1+='$(__git_ps1 "[ ~> on %s ]")'                    # git info
PS1+=$COLOR_L_BLACK'$(svn_info)'$COLOR_END            # svn info
PS1+=$COLOR_YELLOW'$(venv_abspath)'$COLOR_END         # venv absolute path
PS1+='\n'                                             # new line
PS1+='└─'$COLOR_L_CYAN'[\w]'$COLOR_END                # work directory
PS1+='-'$COLOR_PURPLE'[$(distro_name)] \$ '$COLOR_END # distrobution name

# df check every day!
#perl $HOME/bin/dfCheckEveryday.pl
if [[ "$TERM" =~ "rxvt-256color" ]]; then
    cal -3
    #fortune
fi

# display return code of previous command
ret_code() {
    ret=$?
    if [[ "$ret" == "0" ]]; then
        echo "^_^ "
    else
        echo "@_@ $ret "
    fi
}

# show distrobution name
distro_name() {
    grep ^NAME= /etc/os-release | cut -c6- | tr -d '"'
}

# git origin url
git_origin_url() {
    # taken from git-prompt.sh
    local repo_info
    repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
        --is-bare-repository --is-inside-work-tree \
        --short HEAD 2>/dev/null)"

    local origin
    origin="$(git remote get-url origin 2>/dev/null)"

    if [ "$repo_info" = "" ]; then
        echo ""
    elif [ "$origin" = "" ]; then
        echo ""
    else
        echo "[ o=$origin ]"
    fi
}

# show svn info
svn_info() {
    svn info 2>&1 | grep URL
}

# show venv absolute path
venv_abspath() {
    [[ -n "${VIRTUAL_ENV:-}" ]] && echo "[ py=$VIRTUAL_ENV ]" || echo ""
}

# colorize man pages
man() {
    env LESS_TERMCAP_mb=$'\E[1;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[0;7;32m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[0;33m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        man "$@"
}

qr() {
    # Usage: echo "blah" | qr
    qrencode -r /dev/stdin -o /tmp/qr.png && eog /tmp/qr.png
}

# convert unix timestamp (epoch) to date
unixtime() {
    date -d "@$1"
}

clamav-home() {
    # start clamav daemon for multi-threading
    # see https://wiki.archlinux.org/index.php/ClamAV
    sudo systemctl start clamav-daemon.service
    sudo systemctl status clamav-daemon.service -l

    clamdscan --infected --verbose --allmatch --multiscan --fdpass "$HOME"

    sudo systemctl stop clamav-daemon.socket
    sudo systemctl stop clamav-daemon.service
    sudo systemctl status clamav-daemon.service -l
}

system-audit() {
    # https://cisofy.com/lynis/
    sudo lynis audit system

    # https://wiki.archlinux.org/index.php/Rkhunter
    sudo rkhunter --update
    sudo rkhunter --check
}

# shell tools

shellharden-diff() {
    # https://github.com/anordal/shellharden
    vimdiff <(shellharden --transform "$1") "$1"
}

shfmt-diff() {
    # https://github.com/mvdan/sh
    # GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
    vimdiff <(shfmt -i 4 -ci "$1") "$1"
}

# python hacks
style-check() {
    # pip install yapf
    source "$HOME/work/pip/bin/activate"
    local style
    style='{dedent_closing_brackets: true, split_before_logical_operator: false, split_complex_comprehension: true}'
    yapf --style="$style" "$1"
    deactivate
}

style-diff() {
    vimdiff -c 'set syntax=python' <(style-check "$1") "$1"
}

black-diff() {
    # pip install black
    source "$HOME/work/pip/bin/activate"
    black --diff "$1"
    deactivate
}

pep8-check() {
    # see pip/requirements.txt
    source "$HOME/work/pip/bin/activate"
    flake8 --ignore C408,D1 --show-source --import-order-style=google "$1"
    deactivate
}

pylint-check() {
    # pip install pylint
    # fetch https://google.github.io/styleguide/pylintrc to ~/.pylintrc
    # patch `indent-string` to 4 spaces
    source "$HOME/work/pip/bin/activate"
    pylint "$1"
    deactivate
}

vint-check() {
    # pip install vim-vint
    source "$HOME/work/pip/bin/activate"
    vint --color --style-problem "$1"
    deactivate
}

vim-open-search() {
    # open search resault files
    vim -q <(ag --vimgrep "$*") -c ':cwindow'
}

upgrade-pips() {
    command -v pip
    pip install --upgrade pip
    pip install -r <(pip freeze | sed 's/==/>=/') --upgrade
}

wormhole-setup() {
    # quickly setup a magic-wormhole
    # https://github.com/warner/magic-wormhole
    # https://magic-wormhole.readthedocs.io/en/latest/welcome.html

    local venv_name
    venv_name="$(mktemp -u)"
    python3 -m venv "$venv_name"
    source "$venv_name/bin/activate"
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

# fast dev env
archbox() {
    set -x
    podman run --rm -it ghcr.io/xatier/arch-dev bash
    set +x
}

diffoscope() {
    local pwd
    pwd="$PWD"
    podman run --rm -t -w "$pwd" -v "$pwd:$pwd:ro" ghcr.io/xatier/diffoscope-arch:latest "$1" "$2"
}

golangci-lint() {
    # https://github.com/golangci/golangci-lint
    local extra
    extra='goconst,gosec,bodyclose,misspell,unconvert,unparam,whitespace'
    podman run --rm -t -v "$PWD:/app:ro" -w /app golangci/golangci-lint:latest golangci-lint run -E "$extra" -v
}

gosec-lint() {
    # https://github.com/securego/gosec
    podman run --rm -it -v "$PWD:/app:ro" securego/gosec /app/...
}

dockerfile-lint() {
    # https://github.com/hadolint/hadolint

    if [ ! -e Dockerfile ]; then
        echo "Dockerfile not found"
        return 1
    fi

    podman run --rm -i hadolint/hadolint hadolint --ignore DL3007 - <Dockerfile
}

consider-lint() {
    # https://github.com/mroth/consider
    podman run --rm -t -v "$PWD:/mnt:ro" ghcr.io/xatier/consider:latest
}

write-good-check() {
    # https://github.com/btford/write-good
    podman run --rm -v "$PWD:/app:ro" ghcr.io/xatier/write-good:latest "$@"
}

jagger() {
    # https://www.tkl.iis.u-tokyo.ac.jp/~ynaga/jagger/
    echo "$@" | podman run --rm -i xatier/jagger:latest
}

sudachi() {
    # https://github.com/WorksApplications/Sudachi
    echo "$@" | podman run --rm -i xatier/sudachi:latest
}

screenshot() {
    # https://github.com/lupoDharkael/flameshot
    flameshot gui -d 3000
}

jwtinfo() {
    # inspired by https://github.com/lmammino/jwtinfo
    # ignore base64 error since JWT payload may not have proper '=' paddings
    # https://jwt.io/introduction/
    # header
    echo "$1" | cut -d '.' -f 1 | base64 -di | jq 2>/dev/null
    # payload
    echo "$1" | cut -d '.' -f 2 | base64 -di | jq 2>/dev/null
}

exif-remove() {
    # Delete all meta information from an image
    exiftool -all= "$1"
    exiftool "$1"
}

rclone-copy() {
    set -x
    rclone copy -vvP "$1" "childish:$1"
    set +x
}

untar() {
    atool --extract --explain "$1"
}
