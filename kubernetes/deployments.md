# Deployments

## Scale Down / Up

This has to be done through the deployment in the helm chart. Another way to do it is to scale down

```
num=0

kubectl scale --replicas=${num} -n <namespace> deployment/<deploymentname>
```