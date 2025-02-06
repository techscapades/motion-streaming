#!/bin/bash


echo "Updating and upgrading system..."
apt-get update && apt-get upgrade -y && apt autoremove -y

echo "Installing essential packages..."
DEBIAN_FRONTEND=noninteractive apt install python3 python3-pip v4l-utils motion -y
apt install nano curl wget git htop net-tools usbutils libusb-1.0-0 avahi-daemon -y

echo "Cloning motion-streaming repository..."
git clone https://github.com/techscapades/motion-streaming /motion-streaming

echo "Executing motion configuration script..."
bash /motion-streaming/mod-motionconf.sh

if [ -f /cam_name ]; then
    cat /cam_name
else
    echo "Error: /cam_name does not exist!"
fi

ls /dev/video*

echo "to start streaming: bash /motion-streaming/begin-webstream.sh"

