#!/bin/bash

if [ -f "/usr/bin/earnapp" ]; then
	# show the UUID by default
	echo "default node ID of earnapp docker: $(cat /etc/earnapp/uuid)"

	# run the app
	if [ -n "$EARNAPP_UUID" ]; then
		earnapp stop
		echo "Custom UUID set"
		printf $EARNAPP_UUID >/etc/earnapp/uuid
	fi
	echo "Starting application..."
	earnapp start &
	echo "status of earnapp: $(cat /etc/earnapp/status) && new node ID of earnapp: $(cat /etc/earnapp/uuid)"
	sleep 10
	earnapp run
else
	if [ -n "$EARNAPP_UUID" ]; then
		echo "Custom UUID set to $EARNAPP_UUID"
		printf $EARNAPP_UUID >/etc/earnapp/uuid
	fi
	wget -qO- https://brightdata.com/static/earnapp/install.sh >/tmp/earnapp.sh
	echo "Install the app..."
	sudo bash /tmp/earnapp.sh -y
	bash earnapp stop
	echo "status of earnapp: $(cat /etc/earnapp/status)"
fi
