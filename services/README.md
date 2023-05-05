# Service Configuration


Native public cloud managed services are configured using CrossPlane XRDs and Compositions; on platform services such as AppSSO and Spring Cloud Gateway
are configured using their native APIs.

## Content

Service configuration consists of the following folders and content:

** crossplane **

Cross cutting Crossplane configuration.  This includes crossplane `ProviderConfig` such as an AWS provider along
with a supporting AWS credentials secret.

** service-instances **

Configuration needed to create service instances and optional `ClusterInstanceClasses` to integrate with services toolkit dynamic provisioning.  Service instance 
configuration generally takes two forms:

- CrossPlane XRDs and Compositions either create services instances or to wrap connectivity and credential secrets of exsiting service instances.  In either case, XRDs are be
paired with a `ClusterInstanceClass` and are instantiated using a `ClassClaim`.  

- CRs that instantiate on platform services such as Spring Cloud Gateway and AppSSO. 

** claims **

`ClassClaims` and `ResourceClaimss` enabling workloads to bind to service instances.  

## Supported Services

The following services are supported:

### AmazonMQ

This service instance type utilizes AmazonMQ and creates AWS managed RabbitMQ services.  It is implemented with a CrossPlane XRD/Composition which utilizes the CrossPlane AWS
Provider to consume AmazonMQ APIs.  It requires that an AWS `ProviderConfig` be configured that has access to the targeted AWS region.

### AmazonMQ Cred

This is a variant of the AmazonMQ service instance type and assumes a RabbitMQ instance was already created out of band.  It is implemented with a CrossPlane XRD/Composition which wraps an `ExternalSecrect`.  The `ExternalSecret` references a secret inside AWS Secret Manger which contains connectivity and authentication information.  It requires the 
a `ClusterSecretStore` be configured that can access AWS Secrets Manger for given account and AWS region.

### Elasticache

This service instance type utilizes Amazon Elasticache and creates AWS managed Redis services.  It is implemented with a CrossPlane XRD/Composition which utilizes the 
CrossPlane AWS Provider to consume Elasticach APIs.  It requires that an AWS `ProviderConfig` be configured that has access to the targeted AWS region.

### Elasticache Cred

This is a variant of the Elasticache service instance type and assumes a Redis instance was already created out of band.  It is implemented with a CrossPlane XRD/Composition which wraps an `ExternalSecrect`.  The `ExternalSecret` references a secret inside AWS Secret Manger which contains connectivity and authentication information.  It requires the 
a `ClusterSecretStore` be configured that can access AWS Secrets Manger for given account and AWS region.

### RDS Cred

This service instance type assumes an RDS MySQL instance was already created out of band.  It is implemented with a CrossPlane XRD/Composition which wraps an `ExternalSecrect`.  The `ExternalSecret` references a secret inside AWS Secret Manger which contains connectivity and authentication information.  It requires the 
a `ClusterSecretStore` be configured that can access AWS Secrets Manger for given account and AWS region.

### AppSSO

This service instance type creates AppSSO `AuthServer` and `ClientRegistration` resources.  AppSSO service is intended to be deployed on the same cluster as the application
workloads.

### Gateway

This service instance type creates a SpringCloudGateway resource which is intended to be deployed on the same cluster as the application workloads.  

*TBD*  It can also create route and mapping resources.  It is unknown if these resources will be packaged with the application workloads.

## Claims

Claims are used to enable services to be consumed by workloads using service binding.  The following claims are supported:

### AmazonMQ

A `ClassClaim` that dynamically provisions an AWS managed RabbitMQ instance.   

### AmazonMQ Cred

A `ClassClaim` that consumes a pre-provisioned AWS managed RabbitMQ instance.  It requires that the name of the AWS secret that contains the connectivity and auth info to 
be provided.

### Elasticache

A `ClassClaim` that dynamically provisions an AWS managed Redis instance.  

### Elasticache Cred

A `ClassClaim` that consumes a pre-provisioned AWS managed Redis instance.  It requires that the name of the AWS secret that contains the connectivity and auth info to 
be provided.

### RDS Cred

A `ClassClaim` that consumes a pre-provisioned AWS managed RDS MySQL instance.  It requires that the name of the AWS secret that contains the connectivity and auth info to 
be provided.

### AppSSO

A 'ResourceClaim' that references an AppSSO `ClientRegistration`