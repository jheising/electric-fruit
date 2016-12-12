#!/bin/bash

# using local electron module instead of the global electron lets you
# easily control specific version dependency between your app and electron itself.
# the syntax below starts an X istance with ONLY our electronJS fired up,
# it saves you a LOT of resources avoiding full-desktops envs

while true; do
    rm /tmp/.X0-lock &>/dev/null || true
    startx ${PWD}/app/node_modules/electron/dist/electron ${PWD}/app --enable-logging
done