#!/bin/bash
kubectl delete secret aws-secret -n crossplane-system

kubectl create secret \
generic aws-secret \
-n crossplane-system \
--from-file=creds=./aws-credentials.txt 
