# micro3270
A multi-architecture compatible, micro-sized, containerized [3270 emulator](https://en.wikipedia.org/wiki/IBM_3270).  

### Features
- Compiled from latest stable [`c3270`](https://x3270.miraheze.org/wiki/C3270) source
- Multi-architecture compatibility with `x86`, `arm64`, and `s390x`
- Minimized image size using RHEL8 [`ubi8-micro`](https://catalog.redhat.com/software/containers/ubi8/ubi-micro/5ff3f50a831939b08d1b832a) base and docker [multi-stage builds](https://docs.docker.com/build/building/multi-stage/)
- OpenShift Container Platform (OCP) and Kubernetes compatible

![OpenShift Terminal](docs/images/ocp-terminal.png)

## Usage Guide
Run this image using `docker` with a specified z/OS hostname/ip and port.

- `$ZOS_HOST` - The hostname or IP address of a reachable z/OS host
- `$ZOS_PORT` - optional, for specifying a non-default telnet port

### Running Locally
Launch a terminal application and run one of the following commands. 

```bash
docker run -it icr.io/zmodstack/micro3270 $ZOS_HOST $ZOS_PORT
```

### Running in Kubernetes
Run in a Kubernetes environment using the [`deployment.yaml`](kube/deployment.yaml).

```
kubectl apply -f kube/deployment.yml
kubectl set env deploy/micro3270 ZOS_HOST=<ip_or_hostname> ZOS_PORT=<port>
kubectl exec -it deploy/micro3270 -- sh
```

## Building
To build locally using `docker`:
```bash
docker build . -t $NAMESPACE/3270-emulator
```

### Building c3270 from source
This image pulls the latest stable tag, currently `4.2ga9`, from the official `x3270` [GitHub Repository](https://github.com/pmattes/x3270).

Latest stable versions are can be seen on the `x3270` wiki [Downloads page](https://x3270.miraheze.org/wiki/Downloads).