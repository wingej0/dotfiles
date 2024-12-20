#!/usr/bin/env bash

case $1 in
    d) cliphist list | rofi -dmenu -replace -config ~/.dotfiles/home/configs/rofi/config-cliphist.rasi | cliphist delete
       ;;

    w) if [ `echo -e "Clear\nCancel" | rofi -dmenu -config ~/.dotfiles/home/configs/rofi/config-short.rasi` == "Clear" ] ; then
            cliphist wipe
       fi
       ;;

    *) cliphist list | rofi -dmenu -replace -config ~/.dotfiles/home/configs/rofi/config-cliphist.rasi | cliphist decode | wl-copy
       ;;
esac
