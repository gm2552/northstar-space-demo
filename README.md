# northstar-space-demo (i.e. One Tanz/TAP 2.0) Beta 1

## Deliverables-Beta1

This branch contains pre-built deliverable packages of the Where For DInner application that can be installed in a run `Space` 
for the Beta1 release of One Tanzu/TAP 2.0.  It consumes AWS RDS and MQ services using direct secret references in its 
service bindings; you will need deploy an RDS and Amazon MQ (RabbitMQ option) instance which is publicly available for the
application workloads to properly run.  It is also assumed that you have access to TAP 2.0 that has been configured with the
proper traits.

### Install Step

#### Obtain Where For Dinner Deployment Repository

The configuration files for deploying Where For Dinner to your space can be obtained by cloning the following Git repository and switching to the beta1 branch.  
Run the following commands:

```
git clone https://github.com/gm2552/northstar-space-demo
cd northstar-space-demo
git checkout deliverables-beta1
```

#### Update Service Credential Secrets

Using your editor of choice, update the fields with <> placeholders in the serviceSecret.yaml file in the root of this repository with the credentials 
and connection information for the RabbitMQ and MySQL instances.  You will need to base64 encode each secret/credential value before adding it to the serviceSecret.yaml 
file; an easy way to base64 values is to use an online tool such as https://www.base64encode.org.


#### Switch Context To New Space

Switch your kubernetes context to target your newly created by running the following command:

```
tanzu space use <space name>
```

#### Deploy Where For Dinner Application and Configuration To Space

The Where For Dinner deployment consists of the following resources:

- Package and PackageInstall resources
- Secret resources for configuring the PackageInstalls
- Secret resources containing backing service credential/connection info 
- Routing resources for Spring Cloud Gateway and K8s Gateway APIs

Deploy all the application’s resources by running the following command from the root of the northstar-space-demo directory.

```
kubectl apply -f . --recursive --validate=false
```
