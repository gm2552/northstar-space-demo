# Phase 1

The initial phase includes the least amount of automation and therefore requires multiple manual steps.  The following pages will outline high level steps for the
deployment of the various components of the phase 1 demo.

## Prerequisites and Assumptions

The following components, tools, and services are assumed:

- A registered DNS domain
- An AWS account with adequate permission to provision services and create IAM policies and roles.
- Two provisioned EKS clusters running in separate US regions.  Both EKS clusters should be running at least Kubernetes 1.24 and on boarded to Tanzu Service Mesh.
- Tanzu Service Mesh (TSM )console access with access to the two clusters above.
    - A domain and TLS certificate configured in TSM for the Where For Dinner application domain.
- TanzuNet account with access to Tanzu Cluster Essentials and TAP 1.5.x
- Tanzu CLI and kubectl installed and configured to access the clusters above.
- Pre-built carvel packages and GitOps repo of all the Where For Dinner workloads.


## Topology

The following diagram outlines the high level topology of the demo.

![](images/Phase1Toplogy.png)

## Installation

### Install TAP

[Install](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.5/tap/install-intro.html) the TAP run profile on both EKS clusters using the deployment methodology of your choice.  For the sake of resource optimization, you may exclude the following packages from the run profile:
- eventing.tanzu.vmware.com
- cnrs.tanzu.vmware.com

### Create Names Spaces

Workloads are deployed into a runtime namespace that includes also necessary RBAC configuration.  In addition, a namespace for the Spring Cloud Gateway should also be
created due to interaction between the runtime namespace and the Spring Cloud Gateway operator.  There are various was to create a 
[runtime namespace](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.5/tap/namespace-provisioner-provision-developer-ns.html); this document 
will use a basic manual setup that utilizes the TAP namespace provisioner.

Create two namespaces using kubectl on each cluster: one for the Where For Dinner workloads and one for Spring Cloud Gateway

```
kubectl create ns where-for-dinner
kubectl create ns scg
```

If necessary, create a secret registry credential secret for the runtime namespace on each cluster:

```
tanzu secret registry add registry-credentials --server <OCI Registry Server> --username <username> --password <password>  --namespace where-for-dinner
```

Annotate the runtime namespace on each cluster to be managed by the runtime provisioner:

```
kubectl label namespaces where-for-dinner apps.tanzu.vmware.com/tap-ns=""
```

Finally, configuration Tanzu Service Mesh to manage these namespaces on both clusters (requires proper access in the TSM console).

### Install ESO Operator

The services offerings in this phase rely heavily on the use of external secrets stored in AWS secrets manager.  This will required the installation of the External Secrets
Operator (ESO) into the clusters.  The External Secrets Operator package is included as part of the TAP run profile.  To install the ESO package, run the following Tanzu CLI
command against each cluster (version number may differ):

```
tanzu package install eso --package-name external-secrets.apps.tanzu.vmware.com --version 0.6.1+tap.6
```

A `ClusterSecretStore` to be used with AWS secrets manager will configured later in this document.

### Install Spring Cloud Gateway

HTTP request routing is handle by Spring Cloud Gateway (SCG).  The SCG package is also included as part of the TAP run profile.  Spring Cloud Gateway needs to be installed
into the `scg` namespace which requires a custom values file to be created.  Create a file named `scg.yaml` and populate it with the following content:

```
deployment:
  namespace: scg
scgOperator:
  replicaCount: 1
```

To install the SPG package, run the following Tanzu CLI command against each cluster (version number may differ):

```
tanzu package install scg --package-name spring-cloud-gateway.tanzu.vmware.com --version 2.0.0+tap.3 --values-file scg.yaml
```

