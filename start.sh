#!/bin/bash

# Fills config.json
CONFIG=config.json
if ! [ -f "$CONFIG" ]; then
    echo 'OMDb API key:'
    read omdb
    echo 'Discord bot key:'
    read bot_key
    echo 'Discord bot ID:'
    read bot_id
    echo 'Discord admin ID (empty for all access):'
    read admin_id
    printf '{\n  "omdb":"'$omdb'",\n  "bot_key":"'$bot_key'",\n  "bot_id":"'$bot_id'",\n  "admin_id":"'$admin_id'"\n}' > $CONFIG
fi

# Checks architecture before starting Docker
ARCH=`arch`
if [[ "$ARCH" == "x86"* ]]; then
    docker-compose up -d
elif [[ "$ARCH" == "arm"* ]]; then
    docker-compose -f docker-compose-arm.yml up -d
else
    echo 'Unspecified architecture. Defaulting to x86'
    docker-compose up -d
fi

# Runs bot
npm i
node src/bot.js
