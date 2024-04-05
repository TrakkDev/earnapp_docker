#!/bin/bash

if [ -f "/usr/bin/earnapp" ]; then
	# show the UUID by default
	# echo "default node ID of earnapp docker: $(cat /etc/earnapp/uuid)"
	earnapp stop
	UUID=$(cat "/etc/earnapp/uuid")
	# run the app is environement variable is set correctly, stop if not
	if [ "$UUID" == "sdk-node-03169edd1a2549d5ab075c678f785cb2" ]; then
		# Generate a new uuid and set it as env variable
		echo "Creating a new UUID"
		echo $(printf sdk-node- && head -c 1024 /dev/urandom | md5sum | tr -d ' -') >/etc/earnapp/uuid
		export EARNAPP_UUID=$(cat /etc/earnapp/uuid)
	elif [ -n "$EARNAPP_UUID" ]; then
		echo "Writing the UUID set in env $EARNAPP_UUID"
		printf $EARNAPP_UUID >/etc/earnapp/uuid
	fi
	echo "Starting application..."
	earnapp start &
	sleep 5
	echo "Register node ID for earnapp: https://earnapp.com/r/$(cat /etc/earnapp/uuid)"
	sleep 5
	earnapp run
else
	# Install the application
	if [ -n "$EARNAPP_UUID" ]; then
		echo "Custom UUID set to $EARNAPP_UUID"
	fi
	wget -qO- https://brightdata.com/static/earnapp/install.sh >/tmp/earnapp.sh
	echo "Install the app..."
	sudo bash /tmp/earnapp.sh -y
	bash earnapp stop
	# write the default UUID to overwrite
	printf $EARNAPP_UUID >/etc/earnapp/uuid
	echo "status of earnapp: $(cat /etc/earnapp/status)"
fi
