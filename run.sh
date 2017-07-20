#!/bin/bash
docker run \
-it \
-e LOCAL_USER_ID=`id -u $USER` \
-e LOCAL_USER_NAME=$USER \
-e LOCAL_GROUP_ID=`id -g $USER` \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-h "ros_docker_ide"  \
--rm \
--name="ros_docker_ide"  \
--volume="$HOME:$HOME:rw"  \
cbandera/ros_docker_ide \
/usr/bin/tmux
