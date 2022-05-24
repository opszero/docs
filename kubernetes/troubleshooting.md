# Troubleshooting

## List Cluster Resources

CRDs (Customer Resource Definitions) are an important part of this.
As Kubernetes deprecates the API versions you may be installing a resource that no longer is supported.

```
kubectl api-resources
```
