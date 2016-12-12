#!/usr/bin/env bash

sed -i "s/httpredir.debian.org/`curl -s -D - http://httpredir.debian.org/demo/debian/ | awk '/^Link:/ { print $2 }' | sed -e 's@<http://\(.*\)/debian/>;@\1@g'`/" /etc/apt/sources.list

# Get ready to install node
bash <(curl -s https://deb.nodesource.com/setup_6.x)

apt-get install -y \
  nodejs \
  git \
  apt-utils \
  build-essential \
  clang \
  xserver-xorg-core \
  xserver-xorg-input-all \
  xserver-xorg-video-fbdev \
  xorg \
  libdbus-1-dev \
  libgtk2.0-dev \
  libnotify-dev \
  libgnome-keyring-dev \
  libgconf2-dev \
  libasound2-dev \
  libcap-dev \
  libcups2-dev \
  libxtst-dev \
  libxss1 \
  libnss3-dev \
  fluxbox \
  libsmbclient \
  libssh-4 \
  fbset \
  libexpat-dev

# Set Xorg and FLUXBOX preferences
mkdir ~/.fluxbox
echo "xset s off" > ~/.fluxbox/startup && echo "xserver-command=X -s 0 dpms" >> ~/.fluxbox/startup
echo "#!/bin/bash" > /etc/X11/xinit/xserverrc \
  && echo "" >> /etc/X11/xinit/xserverrc \
  && echo 'exec /usr/bin/X -s 0 dpms -nocursor -nolisten tcp "$@"' >> /etc/X11/xinit/xserverrc

# Set npm
npm config set unsafe-perm true

# NPM i app
JOBS=MAX npm i --production

# NPM rebuild node native modules after electron is installed.
./node_modules/.bin/electron-rebuild

echo "#!/bin/sh -e" > /etc/rc.local \
  && echo "" >> /etc/rc.local \
  && echo "bash ${PWD}/start.sh &" >> /etc/rc.local \
  && echo "" >> /etc/rc.local \
  && echo "exit 0" >> /etc/rc.local