#!/bin/bash

function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}

$HOME/.config/bspwm/polybar/launch.sh 
run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &
run "nm-applet"
#run "pamac-tray"
#run "variety"
run "xfce4-power-manager"
#run "blueberry-tray"
#run "/usr/lib/xfce4/notifyd/xfce4-notifyd"
dunst &
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
picom -b  --config ~/.config/picom/picom.conf &
run "numlockx on"
run "xfce4-clipman"
run "volumeicon"
~/.fehbg &
#run "nitrogen --restore"
#feh --bg-scale ~/Downloads/gitthings/catppuccin-wallpapers/wallpapers/misc/cat_bunnies.png

