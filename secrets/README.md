#Secrets

Secrets configuration for external secrets operator (ESO).  

In some cases, credential and connectivity information for native public cloud (NPC )managed services reside in secrets also managed inside the NPC.  One
such example is AWS secrets manager.  The ESO directory contains configuration to setup a `ClusterSecretStore` that consumes secrets from AWS secrets manager.