#!/usr/bin/env bash

# this script fix the functional buttons of my Logitech lift to preferred order

set -x
xinput list
mouse=$(xinput list 'Logitech USB Receiver Mouse' | head -n 1 | perl -lne 'print $1 if /id=(\d+)/')
xinput get-button-map "$mouse"

# `xinput test $mouse` to set button ID
# middle button = 2
# side button 1 = 8 (backword)
# side button 2 = 9 (forward)
# set 8 as 2
# set 9 as 8

# `xinput list $mouse` to get button labels
# Button labels:
#     1 "Button Left"
#     2 "Button Middle"
#     3 "Button Right"
#     4 "Button Wheel Up"
#     5 "Button Wheel Down"
#     6 "Button Horiz Wheel Left"
#     7 "Button Horiz Wheel Right"
#     8 "Button Side"
#     9 "Button Extra"
#    10 "Button Forward"
#    11 "Button Back"
#        None None None None None None None None None

xinput set-button-map "$mouse" 1 2 3 4 5 6 7 2 8 10 11 12 13 14 15 16 17 18 19 20
xinput get-button-map "$mouse"

set +x
