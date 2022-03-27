#!/bin/bash

function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}

$HOME/.config/i3/polybar/launch.sh 
run sxhkd -c ~/.config/i3/sxhkd/sxhkdrc &
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
#run "wal -R"
#feh --bg-scale ~/Downloads/gitthings/catppuccin-wallpapers/wallpapers/minimalistic/flamingo_unicat.png
run "nitrogen --restore"
#run "conky -c $HOME/.config/arco-dwm/system-overview"
#you can set wallpapers in themes as well
#feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &

#run applications from startup

#run "insync start"
#run "spotify"
#run "ckb-next -b"
#run "discord"
#run "telegram-desktop"
