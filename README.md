# Yet another Docker image for 3proxy.

[![Docker Automated build](https://img.shields.io/docker/automated/ayumukasuga/3proxy.svg)](https://hub.docker.com/r/ayumukasuga/3proxy/)

Example:
```
docker run --restart=always --name 3proxy -d -m 100m -p 0.0.0.0:3128:3128/tcp --env LOGIN=user --env PASSWORD=secretpassword ayumukasuga/3proxy
```