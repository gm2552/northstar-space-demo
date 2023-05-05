# Workloads

TAP workload configuration for the Where For Dinner application.  Each service that makes up the Where For Dinner application is
defined in it's own yaml configuration file.  

## Source Code

Each workload references a GitHub repository that contains its source code.  Currently, the application source code is located in the 
repository at [https://github.com/gm2552/where-for-dinner-northstar](https://github.com/gm2552/where-for-dinner-northstar).

## Build and Package

Each workload builds into a carvel package; the intention to build the workload as a carvel package is indicated by the presence of the
`apps.tanzu.vmware.com/carvel-package-workflow: "true"` label.  The build cluster needs to have the appropriate supply chains installed to package
the workloads as a carvel package.  

## Deployment

The build cluster should commit `Package` resources to a GitOps repository after a successful build is complete.  Corresponding `PackageInstall` resources need to be 
created and should also exist in a Git repo as described in the TAP 
[doc](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.5/tap/scc-delivery-with-carvel-app.html).  

