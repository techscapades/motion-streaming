#!/bin/bash

value=$(cat cam_name)
echo "The value from the cam_name file is: $value"

echo "Setting camera parameters in /motion-streaming/${value} to /motion-streaming/motion.conf"
sed -i "s|^video_device .*|video_device $(cat /motion-streaming/${value}/cam_path.txt)|" /motion-streaming/motion.conf
sed -i "s|^webcontrol_port .*|webcontrol_port $(cat /motion-streaming/${value}/webcontrolport.txt)|" /motion-streaming/motion.conf
sed -i "s|^stream_port .*|stream_port $(cat /motion-streaming/${value}/streamport.txt)|" /motion-streaming/motion.conf
echo "Copying /motion-streaming/motion.conf to /etc/motion"
cp -f /motion-streaming/motion.conf /etc/motion/
echo "done"
