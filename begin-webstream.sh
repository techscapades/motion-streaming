#!/bin/bash

echo "============="
echo "hostname and IP addresses"
hostname
hostname -I
echo "============="
avahi-daemon -D
bash /motion-streaming/mod-motionconf.sh
motion
