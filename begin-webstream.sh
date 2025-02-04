#!/bin/bash

echo "============="
echo "hostname and IP addresses"
hostname
hostname -I
echo "============="
avahi-daemon -D
motion
