export XIM=hime
export XIM_PROGRAM=/usr/bin/hime
export XIM_ARGS=
export XMODIFIERS="@im=hime"
export GTK_IM_MODULE=hime
export QT_IM_MODULE=hime
export QT4_IM_MODULE=hime
export QT5_IM_MODULE=hime

#export XMODIFIERS="@im=fcitx"
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx

./bin/srandr

xmodmap ~/.Xmodmap
xrdb ~/.Xresources
urxvtd -q -o -f

# albert &
# flameshot &
# hime &
# pcmanx &
# telegram-desktop &
# whalebird &
# xscreensaver &

# chromium --disk-cache-dir=/tmp/cache &

exec awesome -a >> ~/.cache/awesome_stdout 2>> ~/.cache/awesome_stderr
