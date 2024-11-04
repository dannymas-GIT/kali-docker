#!/bin/bash

# Cleanup
rm -rf /tmp/.X* /tmp/.x*
rm -f /var/run/xrdp/xrdp*.pid

# Setup
mkdir -p /var/run/dbus /var/run/xrdp /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Configure X server
echo "allowed_users=anybody" > /etc/X11/Xwrapper.config

# Start services
dbus-daemon --system --fork
/usr/sbin/xrdp-sesman
exec /usr/sbin/xrdp -nodaemon