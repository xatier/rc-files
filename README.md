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

## bashrc & inputrc

My settings and aliases for bash and readline.

## bin

My collections of little programs

### vpngate and v.sh

- VPN scripts

- requirements

```
pacman -S perl perl-libwww openvpn shadowsocks chromium
```

### srandr

Simple `xrandr`

A dirty script to manage my notebook's screen output using xrandr.

Original script is from [@PkmX](https://github.com/PkmX)

Usage: `srandr [lvds|vga|lvds-vga|vga-lvds|mirror|debug]`

- or like this => `srander[l|v|lv|vl|m]`

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

## ranger

[ranger file manager](https://github.com/ranger/ranger)

## rc.lua

Configuration file for the [awesome wm](https://awesomewm.org/)

- awesome 4.0

- disable some layouts

- use `vim` and `urxvt` as editor and terminal (with urxvt daemon)

- add some widgets

  + network usage
  + text clock
  + CPU usage
  + memory usage
  + and so on ...

- Installation

    + [vicious widgets](http://git.sysphere.org/vicious/log/)

        ```
        pacman -S vicious
        ```

    + pick up a great wallpaper

        ```
        beautiful.wallpaper = "/home/xatierlike/Pictures/something.jpg"
        ```

    + [urxvt terminal emulator](http://software.schmorp.de/pkg/rxvt-unicode.html)

        ```
        pacman -S rxvt-unicode urxvt-perl
        ```

        - add `urxvtd -q -o -f` to your `.xinitrc`

    + check battery name in `vicious.register(batwidget, vicious.widgets.bat, '$2% $3[$1]', 2, 'BAT1')`

        To get the battery name (`BAT0` or `BAT1` for example)

        ```
        ls /sys/class/power_supply/
        ```

    + [shutter-progect](http://shutter-project.org/)

        ```
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

## VS Code

- settings locations

```bash
# Linux
~/.config/Code\ -\ OSS/User/settings.json

# Mac
~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json

# Linux remote
~/.vscode-server-insiders/data/Machine/settings.json
```

- list installed extensions

```bash
$ code --list-extensions --show-versions
CoenraadS.bracket-pair-colorizer@1.0.61
DavidAnson.vscode-markdownlint@0.33.0
docsmsft.docs-yaml@0.2.4
DotJoshJohnson.xml@2.5.0
eamodio.gitlens@10.2.0
lextudio.restructuredtext@116.0.0
ms-pyright.pyright@1.1.16
ms-python.python@2020.1.56281-dev
ms-vscode-remote.remote-containers@0.94.0
ms-vscode-remote.remote-ssh@0.48.0
ms-vscode-remote.remote-ssh-edit@0.48.0
ms-vscode-remote.remote-wsl@0.41.6
ms-vscode-remote.vscode-remote-extensionpack@0.19.0
ms-vscode.azure-account@0.8.7
ms-vscode.cpptools@0.26.2
ms-vscode.Go@0.11.9
ms-vsonline.vsonline@1.0.1424
redhat.vscode-xml@0.10.1
redhat.vscode-yaml@0.6.1
timonwong.shellcheck@0.9.0
VisualStudioExptTeam.vscodeintellicode@1.2.2
vscode-icons-team.vscode-icons@9.7.0
vscodevim.vim@1.12.4
Yukai.vscode-ptt@0.3.2
```

## xinitrc

- [HIME for imput method](http://hime.luna.com.tw/)

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

[ymllint](https://github.com/adrienverge/yamllint) configurations
