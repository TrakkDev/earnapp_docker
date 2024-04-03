# EarnApp Docker
> [!NOTE]
> UNOFFICIAL Containerized Docker Image for BrightData's [EarnApp](https://earnapp.com/)

## Two different ways to start your earnapp docker
Choose the one you prefer

## 1. Generating your own UUID
### Generate your own UUID
 ```echo -n sdk-node- && head -c 1024 /dev/urandom | md5sum | tr -d ' -' ```
### Run
 ```docker run -d -e EARNAPP_UUID='sdk-node-MYGENERATED_UUID' --memory="128m" --cpus=1.5  --restart=always --name earnapp TrakkDev/trakkdev-earnapp:latest ```
### Register
 ```https://earnapp.com/r/sdk-node-MYGENERATED_UUID```
#### END

### 2. Let the UUID be autogenerated
 ```docker run -d --memory="256m" --cpus=1.5  --restart=always --name earnapp TrakkDev/trakkdev-earnapp:latest ```

## Get your node registration link 
### On windows
 ```docker logs earnapp 2>&1 | findstr "sdk-node-"```
### On linux
 ```docker logs earnapp 2>&1 |& grep "sdk-node-"```
#### END

> [!TIP]
> Don't forget to link the node to your earnapp account
> [!IMPORTANT]
> Thanks me by using my referral link : https://earnapp.com/i/xgr824y

## Credits
[@fazalfarhan01](https://github.com/fazalfarhan01/EarnApp-Docker)
[@madereddy](https://github.com/madereddy/EarnApp-Docker)


### Creation TIPS: Enable docker-compose
```docker buildx create --name container --driver=docker-container```
```docker buildx build . -t trakkdev/trakkdev-earnapp:v0.1 --progress plain --platform linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le --builder=container --push```
### Testing/Launching your container
```docker run -d --memory="256m" --cpus=1.5  --restart=always --name earnapp  trakkdev/trakkdev-earnapp:v0.1```
-->