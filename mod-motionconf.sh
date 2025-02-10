#!/bin/bash

# Define the expected file path
file_path="/cam_name"

# Check if the file exists at root
if [ -f "$file_path" ]; then
    # Read the value from the file
    value=$(< "$file_path")
    echo "The value from $file_path is: $value"
else
    echo "Error: File $file_path does not exist at root!"
    exit 1
fi

detected_device=$(v4l2-ctl --list-devices | awk '/USB Camera/{f=1} f && /\/dev\/video/{print $1; exit}')

echo "The value from the cam_name file is: $value"

echo "Setting camera parameters in /motion-streaming/${value} to /motion-streaming/motion.conf"
sed -i "s|^video_device .*|video_device $(cat /motion-streaming/${value}/cam_path.txt)|" /motion-streaming/motion.conf
sed -i "s|^webcontrol_port .*|webcontrol_port $(cat /motion-streaming/${value}/webcontrolport.txt)|" /motion-streaming/motion.conf
sed -i "s|^stream_port .*|stream_port $(cat /motion-streaming/${value}/streamport.txt)|" /motion-streaming/motion.conf
sed -i "s|^video_device.*|video_device $detected_device|" /motion-streaming/motion.conf
echo "Copying /motion-streaming/motion.conf to /etc/motion"
cp -f /motion-streaming/motion.conf /etc/motion/
echo "done"
grep video_device /etc/motion/motion.conf
