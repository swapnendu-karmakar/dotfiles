#!/bin/bash

function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}

run "nm-applet"
#run "pamac-tray"
run "xfce4-power-manager"
#run "blueberry-tray"
#run "/usr/lib/xfce4/notifyd/xfce4-notifyd"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
picom -b  --config ~/.config/picom/picom.conf &
run "numlockx on"
run "xfce4-clipman"
run "volumeicon"
sxhkd -c ~/.config/awesome/sxhkd/sxhkdrc &
#run "nitrogen --restore"
#feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &

