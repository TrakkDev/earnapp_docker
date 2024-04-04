# EarnApp Docker
> [!NOTE]
> UNOFFICIAL Docker Image for BrightData's [EarnApp](https://earnapp.com/)

## How to start your earnapp docker in 3 steps

> Also works with [docker rootless](https://docs.docker.com/engine/security/rootless/)

### 1. Generate your own UUID
Copy and run that command (you can do it afterward in your container)

 ```echo -n sdk-node- && head -c 1024 /dev/urandom | md5sum | tr -d ' -' ```
### 2. Pull and run
Set the UUID environment variable when starting the docker container

 ```docker run -d -e EARNAPP_UUID='sdk-node-MYGENERATED_UUID' --memory="256m" --cpus=1.5  --restart=always --name earnapp TrakkDev/trakkdev-earnapp:latest ```
### 3. Register by completing your new node registration link
You can see your UUID in the container logs

 ```https://earnapp.com/r/sdk-node-MYGENERATED_UUID```


## (Optional) Get your node registration link 
### On windows
 ```docker logs earnapp 2>&1 | findstr "sdk-node-"```
### On linux
 ```docker logs earnapp 2>&1 |& grep "sdk-node-"```

> [!TIP]
> Don't forget to link the node to your earnapp account: https://earnapp.com/r/sdk-node-MY_GENERATED_UUID

> [!IMPORTANT]
> Thanks me by using my referral link : https://earnapp.com/i/xgr824y

## Credits
[@fazalfarhan01](https://github.com/fazalfarhan01/EarnApp-Docker)

[@madereddy](https://github.com/madereddy/EarnApp-Docker)


### Creation TIPS: Enable docker-compose
```docker buildx create --name container --driver=docker-container```

```docker buildx build . -t trakkdev/trakkdev-earnapp:v0.2 --progress plain --platform linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le --builder=container --push```
### Testing/Launching your container
```docker run -d -e EARNAPP_UUID='sdk-node-MYGENERATED_UUID' --memory="256m" --cpus=1.5 --restart=always --name earnapp  trakkdev/trakkdev-earnapp:v0.2```
