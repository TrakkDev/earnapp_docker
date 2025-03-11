# EarnApp Docker
> [!NOTE]
> UNOFFICIAL Docker Image for BrightData's [EarnApp](https://earnapp.com/)

[Dockerhub repository](https://hub.docker.com/repository/docker/trakkdev/earnapp/general)


## How to start your earnapp docker

> Also works with [docker rootless](https://docs.docker.com/engine/security/rootless/)

### 1. Pull and run

 ```docker run -d --memory="256m" --cpus=1  --restart=always --name earnapp TrakkDev/earnapp:latest ```

And that's all folks

### 2. Register by completing your new node registration link
Register your node to your earnapp account. You can see your UUID in the container logs

 ```https://earnapp.com/r/sdk-node-MY_UUID```

#### 3. (Optional) Set your node ID as environment variable

> Set the node ID in an environment variable named EARNAPP_UUID if you want to reinstall the container with the same node ID

```docker run -d -e EARNAPP_UUID='sdk-node-MY_UUID' --memory="256m" --cpus=1  --restart=always --name earnapp TrakkDev/earnapp:latest ```

## How it works

The docker image is built with a base image of ubuntu and run the install script from earnapp website (wget -qO- https://brightdata.com/static/earnapp/install.sh) 

Then an new node ID (UUID) is generated at start and stored in the earnapp /etc/earnapp/uuid file.

> [!IMPORTANT]
> Thanks me by using my referral link : https://earnapp.com/i/xgr824y

## Credits
[@fazalfarhan01](https://github.com/fazalfarhan01/EarnApp-Docker)

[@madereddy](https://github.com/madereddy/EarnApp-Docker)


## Creation TIPS: Enable docker-compose

Create the builder
```docker buildx create --name container --driver=docker-container```

Build for selected platforms
```docker buildx build . -t trakkdev/earnapp:v0.4 --progress plain --platform linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le --builder=container --push```
### Testing/Launching your container
Test your newly built image
```docker run -d -e EARNAPP_UUID='sdk-node-MY_UUID' --memory="256m" --cpus=0.8 --restart=always --name earnapp  trakkdev/earnapp:latest```
