# Predixy Redis Proxy Helm Chart

This Helm chart deploys Predixy as a Redis proxy on Kubernetes.

## Prerequisites
- Kubernetes cluster
- Helm 3+

## Installation

To install the chart, first add the Helm repository or install the chart locally:

```bash
helm install redis-proxy ./predixy-redis-proxy
```

## To upgrade:
```shell
helm upgrade redis-proxy ./predixy-redis-proxy
```

## Configuration
You can customize the configuration by editing the values.yaml file or overriding values at install/upgrade time:
```shell
helm install redis-proxy ./predixy-redis-proxy --set replicaCount=5
```

# Uninstall
To uninstall the chart:
```shell
helm uninstall redis-proxy
```

## Usage
To override any of these values, you can either modify the values.yaml directly or pass them during the Helm install or upgrade command using --set:

```shell
helm install redis-proxy ./predixy-redis-proxy --set ingress.enabled=true --set autoscaling.enabled=true --set serviceAccount.create=true
```

## Values

| Key                                                            | Type   | Default   | Description                                                              |
|----------------------------------------------------------------|--------|-----------|--------------------------------------------------------------------------|
| autoscaling.enabled                                             | bool   | false     | Whether to enable horizontal pod autoscaling                             |
| autoscaling.minReplicas                                         | int    | 1         | Minimum number of replicas for scaling                                   |
| autoscaling.maxReplicas                                         | int    | 3         | Maximum number of replicas for scaling                                   |
| autoscaling.targetCPUUtilizationPercentage                      | int    | 80        | Target CPU utilization percentage                                        |
| autoscaling.targetMemoryUtilizationPercentage                   | int    | 80        | Target memory utilization percentage                                     |
| ingress.enabled                                                 | bool   | false     | Whether to enable the ingress resource                                   |
| ingress.className                                               | string | optional  | Defines the ingress class                                                |
| ingress.annotations                                             | object | optional  | Allows adding custom annotations to the ingress                          |
| ingress.tls                                                     | object | optional  | Contains the TLS configuration for secure communication                  |
| ingress.hosts                                                   | object | optional  | Specifies the domain and path for which the ingress will be set up       |
| ingress.paths                                                   | object | optional  | Defines the paths for each host in the ingress configuration             |
| serviceAccount.create                                           | bool   | false     | Whether to create a service account for the deployment                   |
| serviceAccount.annotations                                      | object | optional  | Allows adding custom annotations to the service account                  |
| serviceAccount.automount                                        | bool   | true      | Controls whether the service account token should be automatically mounted |
| service.port                                                    | int    | 6379      | The port the service will expose                                         |
| service.targetPort                                              | int    | 6379      | The port the application container is listening on                       |
| service.type                                                    | string | LoadBalancer | The type of service to expose (e.g., ClusterIP, LoadBalancer, NodePort) |
| service.selector                                                | object | optional  | Labels to select the appropriate pods for the service                     |
| replicaCount                                                    | int    | 3         | The number of replicas for the deployment                                |
| image.repository                                                | string | opsource/predixy | The Docker image repository for Predixy                                 |
| image.pullPolicy                                                | string | IfNotPresent | The pull policy for the Docker image                                    |
| image.tag                                                       | string | latest    | The Docker image tag for Predixy                                          |
| namespace                                                       | string | redis-cluster | The namespace to deploy the resources into                              |
| config.authConf                                                 | string | optional  | Configuration for authentication, including write and admin modes       |
| config.latencyConf                                              | string | optional  | Configuration for latency monitoring of commands like `get`, `set`, etc. |
| config.predixyConf                                              | string | optional  | Main Predixy configuration, including log levels, worker threads, and included config files |
| config.tryConf                                                  | string | optional  | Configuration for the Redis cluster pool servers, including the connection details |


### Conclusion

This Helm chart creates the necessary Kubernetes resources (ConfigMap, StatefulSet, and Service) for deploying Predixy as a Redis proxy in your cluster. By modifying the `values.yaml` file, you can easily configure various aspects of the deployment, including the number of replicas, image version, and configuration settings.
