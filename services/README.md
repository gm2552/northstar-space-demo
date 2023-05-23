# Services

Configuration necessary for provisioning services.  Native public cloud managed services are configured using CrossPlane XRDs and Compositions; on platform services such as 
AppSSO and Spring Cloud Gateway are configured using their native APIs.

## Content

Service configuration consists of the following folders and content:

**service-offerings**

Configuration needed to define service offerings which integrate with the services toolkit dynamic provisioning feature.  Service offering 
configuration takes the form of CrossPlane XRDs and Compositions which enable one of the following:
- Creating new service instances or to 
- Wrap connectivity and credential secrets of existing service instances.  
In either case, XRDs/Compositions are be paired with a `ClusterInstanceClass` and are instantiated using a `ClassClaim`.  


**claims**

A collection of `ClassClaims` templates enabling the provisioning of service offerings using one of the two methods mentioned above 
and to a enable the ability of workload to bind to a provisioned service.  

## Supported Service Offerings

The following service offerings are supported:

### AmazonMQ (Under Development)

This service offering utilizes AmazonMQ and creates AWS managed RabbitMQ services.  It is implemented with a CrossPlane XRD/Composition which utilizes the CrossPlane AWS
Provider to consume AmazonMQ APIs.  It requires that an AWS `ProviderConfig` be configured that has access to the targeted AWS region.

### AmazonMQ Cred

This is a variant of the AmazonMQ service offering and assumes a RabbitMQ instance was already created out of band.  It is implemented with a CrossPlane XRD/Composition which wraps an `ExternalSecrect`.  The `ExternalSecret` references a secret inside AWS Secret Manger which contains connectivity and authentication information.  It requires the 
a `ClusterSecretStore` be configured that can access AWS Secrets Manger for given account and AWS region.

### Cognito Cred

This service offering assumes an AWS Cognito User Pool and domain was already created out of band.  It is implemented with a CrossPlane XRD/Composition which wraps an `ExternalSecrect`.  The `ExternalSecret` references a secret inside AWS Secret Manger which contains connectivity and authentication information.  It requires the 
a `ClusterSecretStore` be configured that can access AWS Secrets Manger for given account and AWS region.


### Elasticache (Under Development)

This service offering utilizes Amazon Elasticache and creates AWS managed Redis services.  It is implemented with a CrossPlane XRD/Composition which utilizes the 
CrossPlane AWS Provider to consume Elasticach APIs.  It requires that an AWS `ProviderConfig` be configured that has access to the targeted AWS region.

### Elasticache Cred

This is a variant of the Elasticache service offering and assumes a Redis instance was already created out of band.  It is implemented with a CrossPlane XRD/Composition which wraps an `ExternalSecrect`.  The `ExternalSecret` references a secret inside AWS Secret Manger which contains connectivity and authentication information.  It requires the 
a `ClusterSecretStore` be configured that can access AWS Secrets Manger for given account and AWS region.

### RDS Cred

This service offering assumes an RDS MySQL instance was already created out of band.  It is implemented with a CrossPlane XRD/Composition which wraps an `ExternalSecrect`.  The `ExternalSecret` references a secret inside AWS Secret Manger which contains connectivity and authentication information.  It requires the 
a `ClusterSecretStore` be configured that can access AWS Secrets Manger for given account and AWS region.

### Gateway

This service offering creates a SpringCloudGateway instance which is intended to be deployed on the same cluster as application workloads.  It does not expose any
service bindings, but is a convenience method for creating a gateway instance along with a secret that contain SSO credential information.  It is implemented with a 
CrossPlane XRD/Composition which wraps an `ExternalSecrect` along with stamping out SpringCloudGateway resource that includes a reference to the `ExternalSecret`.  
The `ExternalSecret` references a secret inside AWS Secret Manger which contains connectivity and authentication information.  It requires the a `ClusterSecretStore` 
be configured that can access AWS Secrets Manger for given account and AWS region.

*TBD*  It is unknown how route config and route service mappings will be packaged and deployed.

## Claims

Claims are used to enable service instances to be provisioned and consumed by workloads using service binding.  The following claims are supported:

### AmazonMQ (Under Development)

A `ClassClaim` that dynamically provisions an AWS managed RabbitMQ instance.   

### AmazonMQ Cred 

A `ClassClaim` that consumes a pre-provisioned AWS managed RabbitMQ instance.  It requires that the name of the AWS secret that contains the connectivity and auth info to 
be provided.

### RDS Cred 

A `ClassClaim` that consumes a pre-provisioned AWS managed Cognito user pool and domain.  It requires that the name of the AWS secret that contains the connectivity and 
auth info to be provided.

### Elasticache (Under Development)

A `ClassClaim` that dynamically provisions an AWS managed Redis instance.  

### Elasticache Cred

A `ClassClaim` that consumes a pre-provisioned AWS managed Redis instance.  It requires that the name of the AWS secret that contains the connectivity and auth info to 
be provided.

### RDS Cred

A `ClassClaim` that consumes a pre-provisioned AWS managed RDS MySQL instance.  It requires that the name of the AWS secret that contains the connectivity and auth info to 
be provided.

### RDS Cred

A `ClassClaim` that consumes a pre-provisioned AWS Congito OIDC configuration.  It requires that the name of the AWS secret that contains the connectivity and auth info to 
be provided.

### Gateeway

A `ClassClaim` that dynamically provisions an Spring Cloud Gateway instance along with a secret that contains SSO credential information.  It requires that the name of
the AWS secret that contains the SSO connectivity and auth info to be provided.