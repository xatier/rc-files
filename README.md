my rcfiles
==========

usage
-----

clone the repo and add links to the files

```
git clone git@github.com:xatier/rc-files.git
ln -s rc-files/xxx ~/.xxx
```

vimrc
-----

my vimrc


screenrc
-----

use `Ctrl-a` as prefix key

my status line and pre-opened windows

use `Ctrl + <-/->` to switch windows


tmux.conf
-----

use `Ctrl-b` as prefix key

vi-like key bindings

use `Shift + <-/->` to switch windows

bashrc
-----

my settings and aliases

xmodmap
-------

swap `CapsLock` and `Control\_L`

`Usage:  xmodmap ~/.xmodmap`

or run `bin/swapcaps`

srandr
------

Simple xrandr

A dirty script to manage my notebook's screen output using xrandr.


original script by @PkmX (<https://github.com/PkmX>)

modified by @xatier

Usage: `srandr [lvds|vga|lvds-vga|vga-lvds|mirror|debug]`

or simple like this => `srander[l|v|lv|vl|m]`


rc.lua
------

configuration file for the [awesome wm](http://awesome.naquadah.org/)

- for awesome 3.5 (with Lua 5.2)

- disable some layouts

- use vim and urxvt as editor and terminal

- add some widgets

  +network usage
  +text clock
  +CPU usage
  +memory usage

- `Mod4 + F12` to launch xscreensaver-lock

- Installation

    + vicious widgets

        ```
        cd ~/.config/awesome
        git clone http://git.sysphere.org/vicious/
        ```

    + change the path of `theme.lua`  (you can use the default one in `/usr/share/awesome`)

        ```
        beautiful.init("/home/xatierlike/.config/awesome/themes/default/theme.lua")
        ```

    + pick up a great wallpaper

        ```
        beautiful.wallpaper = "/home/xatierlike/Pictures/goodbye.jpg"
        ```

    + urxvt terminal emulator

        - http://software.schmorp.de/pkg/rxvt-unicode.html

        ```
        pacman -S rxvt-unicode urxvt-perl
        ```

    + ranger file manager

        - http://ranger.nongnu.org/

        ```
        pacman -S rxvt-unicode urxvt-perl
        ```

    + check the battery name of this line

        `vicious.register(batwidget, vicious.widgets.bat, '$2% $3[$1]', 2, 'BAT1')`

        to get the battery name (BAT0 or BAT1 for example)

        ```
        ls /sys/class/power_supply/
        ```


    + [shutter-progect](http://shutter-project.org/)

        ```
        pacman -S shutter
        ```

    + xcompmgr

        ```
        pacman -S xcompmgr
        ```


xinitrc
-------

- [HIME for imput method](http://hime.luna.com.tw/)

- xmodmap to swap Capslock and Ctrl

- launch some applications

- launch the awesome wm and keep logs


Xresources
----------

currently only my urxvt configurations

