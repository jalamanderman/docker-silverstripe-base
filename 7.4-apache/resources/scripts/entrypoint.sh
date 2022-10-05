#!/bin/bash
set -e

echo "INFO: Starting web-container..."

#echo "INFO: Installing node $NODE_VERSION"
#volta install node@$NODE_VERSION

if [ -d "/tmp/.ssh" ]
then
    # echo "Copying tmp mounted .ssh to root"
    # cp -R /tmp/.ssh /root/.ssh
    # chmod 700 /root/.ssh
    # chmod 644 /root/.ssh/id_rsa.pub
    # chmod 600 /root/.ssh/id_rsa

    echo "Copying tmp mounted .ssh to docker-dev"
    cp -R /tmp/.ssh /home/docker-dev/.ssh
    chmod 700 /home/docker-dev/.ssh
    chmod 644 /home/docker-dev/.ssh/id_rsa.pub
    chmod 600 /home/docker-dev/.ssh/id_rsa
    chown -R docker-dev:docker-dev /home/docker-dev/.ssh
fi


exec apache2-foreground
