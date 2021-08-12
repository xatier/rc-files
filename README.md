# my rcfiles

## Usage

Clone the repo and put the config files to proper locations.

```bash
git clone git@github.com:xatier/rc-files.git
cp rc-files/xxx ~/.xxx
```

# License(s)

All codes are under their own license(s) from the original projects.

Other codes written by me are under [GPL](https://www.gnu.org/copyleft/gpl.html).

# Config files

## `bashrc`, `bash_profile`, and `inputrc`

My settings and aliases for bash and readline.

## bin

My collections of little programs

### vpngate and v.sh

- VPN scripts

- requirements

```bash
pacman -S perl perl-libwww openvpn shadowsocks chromium openconnect
```

### srandr

Simple `xrandr`

A dirty script to manage my notebook's screen output using xrandr.

Original script is from [@PkmX](https://github.com/PkmX)

Usage: `srandr [lvds|vga|lvds-vga|vga-lvds|mirror|debug]`

- or like this => `srandr[l|v|lv|vl|m]`

## conky.conf

Conky configuration.

## emacs & prelude-modules.el

Emacs stuff

## gdbinit

[GDB](https://www.gnu.org/software/gdb/) debugger settings

## gitconfig

Global [git](https://git-scm.com/) config

## mpv

[MPV Media player](https://github.com/mpv-player/mpv)

## python

`PYTHONSTARTUP` is set to `$HOME/.pythonrc.py` in `bashrc`.

`ipython profile create` to create default ipython config.

Put `ipython_config.py` under `~/.ipython/profile_default/`.

## ranger

[ranger file manager](https://github.com/ranger/ranger)

## rc.lua

Configuration file for the [awesome wm](https://awesomewm.org/)

- awesome 4.0

- disable some layouts

- use `vim` and `urxvt` as editor and terminal (with urxvt daemon)

- add some widgets

  - network usage
  - text clock
  - CPU usage
  - memory usage
  - and so on ...

- Installation

  - [vicious widgets](http://git.sysphere.org/vicious/log/)

    ```bash
    pacman -S vicious
    ```

  - pick up a great wallpaper

    ```lua
    beautiful.wallpaper = "/home/xatierlike/Pictures/something.jpg"
    ```

  - [urxvt terminal emulator](http://software.schmorp.de/pkg/rxvt-unicode.html)

    ```bash
    pacman -S rxvt-unicode urxvt-perl
    ```

    - add `urxvtd -q -o -f` to your `.xinitrc`

  - check battery name in `vicious.register(batwidget, vicious.widgets.bat, '$2% $3[$1]', 2, 'BAT1')`

    To get the battery name (`BAT0` or `BAT1` for example)

    ```bash
    ls /sys/class/power_supply/
    ```

  - [shutter-project](http://shutter-project.org/)

    ```bash
    pacman -S shutter
    ```

## screenrc

Screen settings, didn't use screen for a long long while.

## tmux.conf

- use `Ctrl-b` for prefix key
- vi-like key bindings
- use `Shift + <-/->` to switch windows

## vimrc

My vimrc, simple stuff

Suggest installing [fzf](https://github.com/junegunn/fzf) and [ale](https://github.com/dense-analysis/ale).

```bash
pacman -S fzf

mkdir -p ~/.vim/pack/git-plugins/start
git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
```

## VS Code

- Recommend installing `visual-studio-code-bin` from AUR (Microsoft-branded release)
- settings locations

```bash
# Linux
~/.config/Code/User/settings.json

# Mac
~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json

# Linux remote
~/.vscode-server-insiders/data/Machine/settings.json
```

- list installed extensions

```bash
$ code --list-extensions --show-versions
asvetliakov.vscode-neovim@0.0.82
bierner.emojisense@0.8.0
bierner.github-markdown-preview@0.0.2
bierner.markdown-checkbox@0.1.3
bierner.markdown-emoji@0.1.0
bierner.markdown-mermaid@1.10.0
bierner.markdown-preview-github-styles@0.2.0
CoenraadS.bracket-pair-colorizer-2@0.2.1
DavidAnson.vscode-markdownlint@0.43.2
docsmsft.docs-yaml@0.2.7
eamodio.gitlens@11.6.0
EditorConfig.EditorConfig@0.16.4
esbenp.prettier-vscode@8.1.0
GitHub.copilot@1.3.2335
GitHub.github-vscode-theme@4.1.1
GitHub.remotehub@0.11.0
GitHub.vscode-pull-request-github@0.28.0
golang.go@0.27.0
hbenl.vscode-test-explorer@2.20.4
lextudio.restructuredtext@155.0.0
mhutchie.git-graph@1.30.0
ms-azuretools.vscode-azureresourcegroups@0.4.0
ms-azuretools.vscode-azurevirtualmachines@0.4.0
ms-azuretools.vscode-docker@1.15.0
ms-python.python@2021.8.1105858891
ms-python.vscode-pylance@2021.8.1
ms-toolsai.jupyter@2021.8.1054968649
ms-vscode-remote.remote-containers@0.187.1
ms-vscode-remote.remote-ssh@0.65.7
ms-vscode-remote.remote-ssh-edit@0.65.7
ms-vscode-remote.vscode-remote-extensionpack@0.21.0
ms-vscode.azure-account@0.9.8
ms-vscode.cpptools@1.5.1
ms-vscode.test-adapter-converter@0.0.13
ms-vscode.vscode-typescript-next@4.5.20210811
ms-vsliveshare.vsliveshare@1.0.4673
octref.vetur@0.34.1
redhat.fabric8-analytics@0.3.3
redhat.vscode-commons@0.0.6
redhat.vscode-xml@0.18.0
redhat.vscode-yaml@0.22.0
rvest.vs-code-prettier-eslint@3.0.4
samuelcolvin.jinjahtml@0.16.0
sourcery.sourcery@0.9.3
streetsidesoftware.code-spell-checker@1.10.2
sumneko.lua@2.3.6
timonwong.shellcheck@0.15.2
tomoki1207.pdf@1.1.0
VisualStudioExptTeam.vscodeintellicode@1.2.14
vscode-icons-team.vscode-icons@11.6.0
vscodevim.vim@1.21.6
```

- install extensions

```bash
code --install-extension <extension ID>
```

## xinitrc

- [HIME for input method](http://hime.luna.com.tw/)

- xmodmap to swap Capslock and Ctrl

- launch some applications

- launch the awesome wm and keep logs

## xmodmap

Swap `CapsLock` and `Control\_L`

Usage:  `xmodmap ~/.xmodmap`

- or run `bin/swapcaps`

## Xresources

[rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html) configurations

## yamllint

[yamllint](https://github.com/adrienverge/yamllint) configurations
