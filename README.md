# No Service Bindings
The branch contains configuration to build WFD workloads without service bindings.  Instead it uses
ENV variables references secrets to set well know Spring configuration parameters for MySQ and 
RabbitMQ.

## Build Workloads
Workload build configuration is containeed in the `workloads` directory.  Simply change to the
`workloads` directory and run the following commnand substituting the appropriate namespace 
to submit builds to a supply chain.

```
kubectl apply -f . -n <namepsace> 
```
