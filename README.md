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

    disable some layouts

    use vim and urxvt for editor and terminal 

    add some widgets 
        network usage
        text clock
        CPU usage
        memory usage

    Mod4 + F12 to launch xscreensaver-lock


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

