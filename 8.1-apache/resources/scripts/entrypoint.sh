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

if [ $NODE_VERSION ]; then
    current_node_version=$(node -v | tr -d "v")
    if [ "$NODE_VERSION" != "$current_node_version" ]; then
        echo "Node versions don't match, installing desired Node version based on environment variable: $NODE_VERSION"
        . "$NVM_DIR/nvm.sh" && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION
        NODE_PATH="$NVM_DIR/v$NODE_VERSION/lib/node_modules"
        PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH"
    fi
fi

exec apache2-foreground
