# Predixy Docker Image

This repository provides a Docker image for running **Predixy**, a Redis proxy. The image is built using a two-stage Dockerfile based on the **Debian Bullseye** distribution. The build stage compiles Predixy from source, and the runtime stage sets up the necessary environment to run the compiled binary.

## Overview

Predixy is a proxy server that improves Redis' performance, scalability, and management. This Docker image allows you to easily deploy Predixy in your infrastructure with minimal setup.

### Key Features:
- Build and runtime environments are separated for efficiency and security.
- A non-root user is used to run Predixy for security.
- Exposes Predixy's default port (7617).
- Simple setup for running Predixy with a default configuration.

## Docker Image Details

The Docker image is built using a **multi-stage Dockerfile** consisting of:
1. **Build Stage**: The dependencies required for building Predixy are installed, and the source code is compiled.
2. **Runtime Stage**: The built Predixy binary and configuration files are copied into a clean image with minimal dependencies for runtime.

## Getting Started

To use this Docker image, follow these steps:

### Pull the Docker Image
You can pull the latest version of the image from the Docker Hub (or a custom registry if provided):

```bash
docker pull opsource/predixy
```
Or 

```shell
git clone https://github.com/vahidaghazadeh/predixy.git
```

Run a container with Predixy:
```shell
docker run -d -p 7617:7617 opsource/predixy
```
This will run the Predixy server, exposing the default port 7617.

### Customizing the Configuration
If you need to customize the Predixy configuration, you can mount a local configuration file to the container:
```shell
docker run -d -p 7617:7617 -v /path/to/your/predixy.conf:/etc/predixy/predixy.conf <your-docker-image>
```
This will use your custom configuration file instead of the default one.

# Dockerfile Breakdown
The runtime stage sets up the environment for running the Predixy server. It installs necessary runtime dependencies, copies the compiled binary, and configures the system to run [Predixy](https://github.com/joyieldInc/predixy).
```shell
cd docker
```

```shell
docker build -t predixy -f Breakdown.dockerfile
```

```shell
docker run -p 7617:7617 predixy /bin/bash
```

# Runtime Stage
The runtime stage sets up the environment for running the [Predixy](https://github.com/joyieldInc/predixy) server. It installs necessary runtime dependencies, copies the compiled binary, and configures the system to run Predixy.
```shell
cd docker
```

```shell
docker build -t predixy .
```

```shell
docker run -p 7617:7617 predixy /bin/bash
```

## Exposed Ports
`7617` The default port for Predixy to listen on.

# Kubernetes Deployment
For deploying Predixy in a Kubernetes cluster, a StatefulSet resource is defined, which allows for stable and scalable deployment of Redis proxies across multiple nodes.

You can refer to the Kubernetes deployment files located in the k8s directory for the complete configuration. The deployment uses a StatefulSet and a ConfigMap to manage configuration files and handle the scaling of Predixy pods.

## Components:
- StatefulSet: Manages the deployment of Predixy pods with persistent identities and stable networking.
- ConfigMap: Stores configuration files (predixy.conf, auth.conf, latency.conf, etc.) that are mounted into the Predixy containers at runtime.
The Kubernetes configuration defines the following:

- A StatefulSet with 3 replicas of the Predixy container.
- A ConfigMap with the Predixy configuration, including settings for authentication, latency monitoring, and cluster server pools.
Mounting of configuration files to the container's file system, ensuring proper configuration management.
- Node affinity is set to ensure that Predixy pods run only on nodes labeled for redis-cluster.
To deploy, simply apply the Kubernetes YAML files in the k8s path:
```shell
kubectl create -f k8s/configmap.yaml
```
```shell
kubectl create -f k8s/sts.yaml
```

## License
This Docker image is based on the Predixy repository, which is licensed under the MIT License.

## Contributing
Feel free to open an issue or submit a pull request if you have suggestions or improvements to this Docker image. Contributions are welcome!

## Support
For help and support, please refer to the official [Predixy](https://github.com/joyieldInc/predixy) documentation and [Redis](https://redis.io/docs) documentation.

