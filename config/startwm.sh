#!/bin/bash
unset DBUS_SESSION_BUS_ADDRESS
export XDG_SESSION_TYPE=x11
export DESKTOP_SESSION=xfce
export DISPLAY=:0
exec dbus-launch --exit-with-session startxfce4