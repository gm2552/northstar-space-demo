# northstar-space-demo
Configuration repository for NorthStar Space Apps demo.  This repository contains configuration in various folders and branches
that include initial bootstrapping configuration as well as GitOps based configurations.

## Repository Content

This repository consists of multiple branches where each branch serves a specific configuration role.

* main - Consists of the application workload.yaml files as well as service configuration that may be incorporated later on into `space` templates.

### Main Branch

The `main` branch consists of the following folders and content  

[Workloads](workloads/README.md) 

The `workload` files for each discrete service.  These workloads are intended to be submitted to a build cluster which results in carvel `packages`
that uploaded to an image repository and `package` configuration that is commited to a GitOps repository.

[Services](services/README.md) 

Configuration related to creating service instances needed by the application.  Configuration includes CrossPlane resources such as XRDs, Compositions,
Providers, as well as TAP Services Toolkit resources such as `ClusterInstanceClass` and `ClassClaim`.  

[Secrets](secrets/README.md) 

Configuration for creating `ClusterSecretStores` for external secrets.   