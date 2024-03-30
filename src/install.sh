#!/bin/bash
if [ -f "/usr/bin/earnapp" ]; then
    # run the app
    bash earnapp start
    echo "Application started because already installed"
else
    if [ -n "$EARNAPP_UUID" ]
        echo "Custom UUID set"
        printf $EARNAPP_UUID > /etc/earnapp/uuid
    fi
    wget -qO- https://brightdata.com/static/earnapp/install.sh > /tmp/earnapp.sh 
    sudo bash /tmp/earnapp.sh -y
    echo "status of earnapp:" | cat /etc/earnapp/status
fi
sleep 10
earnapp run