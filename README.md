Aim: Dockerise motion-project and run a custom config file to allow webstreaming and authentication

setup on linux host:
1. download docker
2. docker pull ubuntu
3. wget -O /home/$USER/WS-setup.sh https://raw.githubusercontent.com/techscapades/motion-streaming/main/WS-setup.sh
4. docker run -t -d --privileged --network host -v /home/$USER/WS-setup.sh:/WS-setup.sh --name cam-videostream ubuntu bash -c "echo 'cam1' > /cam_name && tail -f /dev/null"
5. docker exec -it cam-videostream /bin/bash
6. bash WS-setup.sh

to start streaming:

docker start cam-videostream && docker exec -d cam-videostream /bin/bash /motion-streaming/begin-webstream.sh

Modification of cam1-cam4:
1. the cam_path.txt file is deprecated, it scans the available video devices instead and sets that dynamically before motion begins
2. the docker run command has this parameter: "echo 'cam1' , this will set all cam1 parameters defined in the cam1 subfolder 

modifications made to motion.conf:
1. video_device /dev/video3
2. framerate 30
3. #text_left CAMERA1
4. #text_right %Y-%m-%d\n%T-%q
5. movie_output off
6. webcontrol_localhost off
7. webcontrol_port 18510
8. stream_localhost off
9. stream_port 18511

added:

1. stream_maxrate 30
2. stream_quality 50
3. webcontrol_auth_method 1
4. webcontrol_authentication admin:password
5. stream_auth_method 1
6. stream_authentication admin:password
