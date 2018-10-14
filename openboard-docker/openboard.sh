xhost local:root
cd $HOME
docker run -u `id -u`:`id -g` \
 -v `pwd`:`pwd` -w `pwd` \
 -v $HOME/.local/share/OpenBoard/:$HOME/.local/share/OpenBoard/ \
 -v $(readlink -f /$HOME/Collège):$HOME/Collège \
 -v /tmp/.X11-unix:/tmp/.X11-unix \
 --name openboard_app \
 -e DISPLAY=unix$DISPLAY ubuntuopenboard

docker rm openboard_app
