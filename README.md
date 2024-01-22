# No service binding deliverables

## Deliverables-Beta1

This branch contains pre-built deliverable packages of the Where For DInner application that can be installed in a run `Space` 
for the Beta1 release of One Tanzu.  The difference between this deployment and the Beta 1 branch is that the workloads do not
use service bindings.  Instead they use ENV variables that reference secrets store in the `serviceSecret.yaml` file.

### Install Step

#### Obtain Where For Dinner Deployment Repository

The configuration files for deploying Where For Dinner to your space can be obtained by cloning the following Git repository and switching to the beta1 branch.  
Run the following commands:

```
git clone https://github.com/gm2552/northstar-space-demo
cd northstar-space-demo
git checkout deliverables-no-service-bindings
```

#### Create Services

The application configuration of Where For Dinner for the Beta 1 utilizes MySQL and RabbitMQ and consumes credentials/connection information via a 
direct secret reference.  An easy option to create these services is to use an offering from a cloud provider like AWS.  The following sections walk you
through creating an Amazon RDS database and a RabbitMQ cluster that can be consumed by the Where For Dinner application.  The subsequent 
`Update Service Credential Secrets` section will articulate how you will populate the service credentials/connection information into a Kubernetes secret.

##### Create MySQL RDS Instance

To create a MySQL instance, search for RDS in the AWS Web Console, click the "Create database" button, select "Standard create", and select "Aurora (MySQL Compabile)."  
Select "Dev/Test" as the template, give the cluster a name of your choice, and supply a master username and password in "Credential Settings" (you will need the user/password)
in the appropriate secret fields).  For "Instance configuration", select a smaller size in the "Burstable classes" class; db.t4g.large is appropriate.  Under "Connectivity", 
chose "Yes" for "Public access."  You can turn off performance insights if you wish.  Under "Additional configuration", provide an "Initial database name" such as 
"dinner"; you can disable backups as well if you wish.  Finally, click "Create database.

After the database has been created and is available, click on the writer instance of your database from the list of databases clusters and scroll down to the 
"Connectivity & security" section.  Note the endpoint and port as these will be used as the host and port fields in the secret.

##### Create RabbitMQ Cluster

To create a RabbitMQ instance, search for AmazonMQ in the AWS Web Console.  Click "Create brokers" and select RabbitMQ as the broker engine.  You can choose settings of your
preference through the rest of the wizard, but you will need to provide a username/password which you will need to remember when creating the secret.   You should also select
"Private access" for "Access type".  After providing all settings, click "Next" then "Create broker"; it may take up to 20 minutes for the broker to be provisioned.

After the broker has been created, click the broker name from the list of brokers and scroll down to the "Connections" sections.  Note the AMQP endpoint as this will be 
used in the secret.

##### Update External Hostname

Where For Dinner uses an `HTTPRoute` resource to create an externally resolvable and accessible endpoint on the internet.  The hostname portion of the externally addressable address is controlled by the `spec.parentRefs.sectionName` of the `HTTPRoute` resource.  The `sectionName` field's value is prefixed with http- and then followed by the desired hostname.  For example, a value of *http-where-for-dinner* would result in a hostname of *where-for-dinner*.

Using your editor of choice, update the field with the <hostname> placeholder in the k8sgatewayReoutes.yaml file in the /routes directory of this repository with the your desired hostname.  

**NOTE/IMPORTANT:** the host name for each deployed instance of Where For Dinner should be unique if you are deploying multiple instances of where for dinner that utilize the same domain name (the domain name is controlled by the public-ingress trait). 

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
