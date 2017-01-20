my rcfiles
==========

Usage
-----

Clone the repo and add links to the files

```
git clone git@github.com:xatier/rc-files.git
cp rc-files/xxx ~/.xxx
```

License
-------

All codes are under their own license(s) from the original projects.

Other codes written by me are under [GPL](https://www.gnu.org/copyleft/gpl.html).


vimrc
-----

my vimrc, simple stuff


tmux.conf
-----

- use `Ctrl-b` as prefix key

- vi-like key bindings

- use `Shift + <-/->` to switch windows


bashrc & inputrc
-----

My settings and aliases


xmodmap
-------

swap `CapsLock` and `Control\_L`

Usage:  `xmodmap ~/.xmodmap`

    - or run `bin/swapcaps`


srandr
------

Simple xrandr

A dirty script to manage my notebook's screen output using xrandr.

Original script by [@PkmX](https://github.com/PkmX), modified by @xatier

Usage: `srandr [lvds|vga|lvds-vga|vga-lvds|mirror|debug]`

    - or simple like this => `srander[l|v|lv|vl|m]`


rc.lua
------

Configuration file for the [awesome wm](https://awesomewm.org/)

- for awesome 4.0

- disable some layouts

- use vim and urxvt as editor and terminal (with urxvt daemon)

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

    + [ranger file manager](https://github.com/ranger/ranger)

        ```
        pacman -S ranger
        ```

    + check the battery name

        `vicious.register(batwidget, vicious.widgets.bat, '$2% $3[$1]', 2, 'BAT1')`

        to get the battery name (BAT0 or BAT1 for example)

        ```
        ls /sys/class/power_supply/
        ```


    + [shutter-progect](http://shutter-project.org/)

        ```
        pacman -S shutter
        ```


xinitrc
-------

- [HIME for imput method](http://hime.luna.com.tw/)

- xmodmap to swap Capslock and Ctrl

- launch some applications

- launch the awesome wm and keep logs


Xresources
----------

Currently only my urxvt configurations


vpngate and v.sh
----------------

- VPN scripts

- requirements

```
pacman -S perl perl-libwww openvpn shadowsocks chromium
```
