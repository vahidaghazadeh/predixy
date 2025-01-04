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


### Conclusion

This Helm chart creates the necessary Kubernetes resources (ConfigMap, StatefulSet, and Service) for deploying Predixy as a Redis proxy in your cluster. By modifying the `values.yaml` file, you can easily configure various aspects of the deployment, including the number of replicas, image version, and configuration settings.
