#!/bin/bash
while true ; do
 neofetch --config "$HOME/.config/neofetch/mini.conf" --off --colors fg fg fg fg fg fg >> /tmp/neofetch
 echo -en "\e[17A"
 cat /tmp/neofetch
 sleep 5s
done
