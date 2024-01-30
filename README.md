# No Service Bindings
The branch contains configuration to build WFD workloads without service bindings.  Instead it uses
environment variable referencing secrets to set well know Spring configuration parameters for MySQ and 
RabbitMQ.

## Build Workloads
Workload build configuration is contained in the `workloads` directory.  It is further split out in supply chain V1
and V2 directories depending on which supply chain system you want to use to build your workloads..

### Supply Chain V1

Simply change to the `workloads\v1` directory and run the following command substituting the appropriate namespace 
to submit builds to a supply chain.

```
kubectl apply -f . -n <namepsace> 
```

### Supply Chain V2

This supply chain assumes you have installed TAP Supply Chain and associated component packages.

Change to the `workloads\v2` directory and run the following command substituting the appropriate namespace 
to install the supply chain and components.

```
kubectl apply -f ./supplychains -n <namepsace> 
```

Run the following command substituting the appropriate namespace to submit builds to a supply chain.

```
kubectl apply -f . -n <namepsace> 
```
