#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Thinkpad T420 configuration

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Read Xresources configuration
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start Network Manager applet
#exec nm-applet &

# Start Compton
exec compton &

# Start transset-df
#exec transset-df -m 0 &

# Trackpoint configuration
tpset() { xinput set-prop "TPPS/2 IBM TrackPoint" "$@"; }

tpset "Evdev Wheel Emulation" 1
tpset "Evdev Wheel Emulation Button" 2
tpset "Evdev Wheel Emulation Timeout" 200
tpset "Evdev Wheel Emulation Axes" 6 7 4 5
tpset "Device Accel Constant Deceleration" 0.95

# Read Xmodmap on Thinkpad
#xmodmap ~/.Xmodmap

## Disable beeps
xset -b &

# Start clipboard
#exec parcellite &

# Start notifications
#exec dunst &

# Export PATH for graphical envirorment
export PATH="${PATH}:/home/robert/scripts"

# Initize enviroment variables for dbus
dbus-update-activation-environment --systemd --all

# Start i3-gaps window manager
exec i3
