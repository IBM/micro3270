# Using micro3270 in a Kubernetes Environment
You can run `micro3270` from a Kubernetes environment like [OpenShift Container Platform](https://www.redhat.com/en/technologies/cloud-computing/openshift). In Kubernetes environments, the `micro3270` image is set to auto-start the `c3270` terminal emulator when a user `exec`'s into the running Pod. 


## Basic Configuration
Run in a Kubernetes environment using the [`deployment.yml`](deployment.yml). This option only allows setting some basic configuration of the `ZOS_HOST` and `ZOS_PORT` for z/OS connectivity.

```
kubectl apply -f deployment.yml
kubectl set env deploy/micro3270 ZOS_HOST=<ip_or_hostname> ZOS_PORT=<port>
kubectl exec -it deploy/micro3270 -- sh
```

This deployment method does not allow any customization of the `c3270` [command-line options](https://x3270.miraheze.org/wiki/C3270/Command-line_options). See [custom configuration](#custom-configuration) for additional guidance.

## Custom Configuration
The `micro3270` image is configured to look for additional configuration files located in the `/micro3270/config` directory. To supply `c3270` [command-line options](https://x3270.miraheze.org/wiki/C3270/Command-line_options), an additional `ConfigMap` can be created and mounted into the Pod. 

1. Copy [`configmap.yml`](configmap.yml), modify, and post your `configmap.yml` to Kubernetes
    ```bash
    kubectl apply -f configmap.yml
    ```
2. Post the `deployment-with-config.yml` to Kubernetes
    ```bash
    kubectl apply -f deployment-with-config.yml
    kubectl exec -it deploy/micro3270 -- sh
    ```

## TLS Configuration
When connecting to a z/OS environment that requires TLS connectivity with a self-signed certificate, the [custom configuration](#custom-configuration) steps may be followed with the PEM encoded certificate added to the `ConfigMap` as seen below.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: micro3270-config
data:
  .c3270: |
    c3270.caFile: /micro3270/config/common_cacert
    c3270.port: <secure-port>
    c3270.hostname: <hostname-or-ip>
  common_cacert: |
    -----BEGIN CERTIFICATE-----
    ... <additional base64 chars here> ...
    -----END CERTIFICATE-----
```

Note: Leave the `c3270.caFile` path as shown above as the volume mount defaults are all properly set in the `deployment-with-config.yml`. If you modify this path, additional changes may be necessary in the `Deployment`.