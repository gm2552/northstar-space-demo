# Phase 1

The initial phase includes the least amount of automation and therefore requires multiple manual steps.  The following pages will outline high level steps for the
deployment of the various components of the phase 1 demo.

## Prerequisites

The following components, tools, and services are assumed:

- A registered DNS domain
- An AWS account with adequate permission to provision services and create IAM policies and roles.
- Two provisioned EKS clusters running in separate US regions.  Both EKS clusters should be running at least Kubernetes 1.24 and on boarded to Tanzu Service Mesh.
- Tanzu Service Mesh (TSM )console access with access to the two clusters above.
    - A domain and TLS certificate configured in TSM for the Where For Dinner application domain.
- TanzuNet account with access to Tanzu Cluster Essentials and TAP 1.5.x
- Tanzu CLI and kubectl installed and configured to access the clusters above.


## Topology

The following diagram outlines the high level topology of the demo.

![](images/Phase1Toplogy.png)