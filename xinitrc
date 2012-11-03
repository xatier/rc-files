export XIM=hime
export XIM_PROGRAM=/usr/bin/hime
export XIM_ARGS=
export XMODIFIERS="@im=hime"
export GTK_IM_MODULE=hime
export QT_IM_MODULE=hime
export QT4_IM_MODULE=hime

xmodmap ~/.xmodmap
xrdb ~/.Xresources


hime &
chromium &
turpial &
pcmanx &
dropboxd &
xscreensaver &
gnome-settings-daemon &
gnome-sound-applet &
nm-applet &


exec awesome >> ~/.cache/awesome_stdout 2>> ~/.cache/awesome_stderr

