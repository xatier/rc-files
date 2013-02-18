my rcfiles
==========

usage
-----
using soft link generate config files under your home directory

`ln -s ${DIR}/rc-files/xxx ~/.xxx`

vimrc
-----
my vimrc


screenrc
-----
play with nethack(?)

tmux.conf
-----
using C-b as prefix key

vi-like key binding

bashrc
-----
my bashrc template

    need to install:
        `luit` for big-5 endocing telnet(Taiwanese BBS)
        `fortune` for interesting  things
        `w3m` text-based web browser
        `curl` for imgur script

    


xmodmap
-------
using xmodmap to swap CapsLock and Control\_L

from the EXAMPLE in `man xmodmap`

`Usage:  xmodmap ~/.xmodmap`

srandr
------
Simple xrandr

A dirty script to manage my notebook's screen output using xrandr.


original script by PkmX (<https://github.com/PkmX>)

modified by xatier

    Usage: srandr [lvds|vga|lvds-vga|vga-lvds|mirror|debug]
    or simple like this => srander[l|v|lv|vl|m]

rc.lua
------

configuration file for the awesome wm <http://awesome.naquadah.org/>

    fit for awesome 3.5 (with Lua 5.2)

    disable some layouts

    use vim and urxvt for editor and terminal 

    add some widgets 
        network usage
        text clock
        CPU usage
        memory usage

    Mod4 + F12 to launch xscreensaver-lock

    Installation
        vicious widgets

            `cd ~/.config/awesome`
            `git clone http://git.sysphere.org/vicious`
        
        change the path of `theme.lua`  (maybe you can use the default one in /usr/share/awesome)

            `beautiful.init("/home/xatierlike/.config/awesome/themes/default/theme.lua")`

        pick up a great wallpaper

            `beautiful.wallpaper = "/home/xatierlike/Pictures/goodbye.jpg"`

        urxvt terminal emulator

            <http://software.schmorp.de/pkg/rxvt-unicode.html>

            `pacman -S rxvt-unicode urxvt-perl`

        ranger file manager

            <http://ranger.nongnu.org/>

        check the battery name of this line

            `vicious.register(batwidget, vicious.widgets.bat, '$2% $3[$1]', 2, 'BAT1')`

            to get the battery name (BAT0 or BAT1 for example)
            `ls /sys/class/power_supply/`

        xdotool

            `pacman -S xdotool`

        shutter-progect <http://shutter-project.org/>

            put it under /opt/shutter

        xcompmgr

            `pacman -S xcompmgr`

xinitrc
-------

    use HIME for imput method <http://hime.luna.com.tw/>

    xmodmap to swap Capslock and Ctrl

    launch some applicatoins

    launch the awesome wm and keep logs


Xresources
----------
    currently only my urxvt configurations

w3m
-----
w3m web browser   <http://w3m.sourceforge.net/>

    color favor

    meta-q     CLOSE_TAB                                                          
    x          CLOSE_TAB                                                              
    Ctrl-f     NEXT_PAGE                                                            
    Ctrl-b     PREV_PAGE                                                            
    F          NEXT

