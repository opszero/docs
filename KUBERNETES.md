# Kubernetes

We setup Kubernetes using the managed service provider on each of the Cloud
providers. AWS EKS, Google Cloud GCE, Azure AKS. This ensures that we don’t need
to handle running the master nodes which can create additional operational
hurdles. We remove this from the picture as much as possible.

Kubernetes will be running with the following things:

 - Ingress controller to reduce the expense of running multiple LoadBalancers
Nodes
Nodes can be configured using Terraform. Each of the modules for EKS, GCP, AKS
have configuration options for adding and additional nodes. Further, you can
specify the size and type of the nodes using the Terraform script as well. This
should be the variables min_size and max_size. The amount of nodes that a master
does not need to be configured and is handled by the managed service providers.

The way to add additional nodes to the cluster is to increase the min_size of
the nodes. This will create additional nodes in the cluster. Note that it may
take up to 5 minutes to bring up additional nodes but there is not downtime. You
can also do the same by reducing the min_size. This will remove the pods and
move them to different nodes. Ensure that your code is idempotent to handle
cases where the service may be killed.

The way to increase the size is to modify the terraform script and run terraform
apply. This will update the configuration. Further, with Azure and GCP we can
specify auto update. With EKS there needs to be a manual process for building
the nodes updating and replacing them which is described in the AWS section.

Request Cycle

Pods are a group of containers. They are in the simplest form a group of pods
that run on the same node together. The way you specify the pods is through a
deployment and how you expose these to the outside world is through a service
and ingress. An example of a HTTP request looks like this:

```
DNS (i.e app.example.com) -> Ingress (Public IP Address/CNAME) -> Kubernetes Service -> Kubernetes Pods
```


## kubeconfig

### AWS

Ensure you have access to EKS. This is done by adding your IAM to the EKS in the
terraform configuration.

Get the credentials

```
KUBECONFIG=./kubeconfig aws --profile=account eks update-kubeconfig --cluster cluster-name
```

There can be multiple clusters so pick the correct cluster.

Ensure that you set `export KUBECONFIG=./kubeconfig` to get the correct `KUBECONFIG`
file. This can be added into you .bashrc or .zshrc

## Pods
### List Running Pods

``` sh
kubectl get pods -A
```

Kubernetes lets you divide your cluster into namespaces. Each namespace can have
its own set of resources. The above command lists all running pods on every
cluster. Pods in the kube-system namespace belong to Kubernetes and helps it
function.


### “SSH”

To connect to the application look at the namespaces:

``` sh
kubectl get pods --all-namespaces
kubectl exec -it -n <namespace> <pod> -c <container> -- bash
```


### Logs

``` sh
kubectl get pods --all-namespaces
kubectl logs -f -n <namespace> <pod> -c <container>
```

This lets you view the logs of the running pod. The container running on the pod
should be configured to output logs to STDOUT/STDERR.

### Describe Pods

Troubleshooting Pods

kubectl describe pods

Common Errors:

 - OOMError
 - CrashLoopBackup
 - ImageNotFound

## Restart a Pod

If you pod is not responding or needs a restart the way to do it is to use the
following command. This will delete the pod and replace it with a new pod if it
is a part of a deployment.

kubectl delete pod <pod-name>

## Deployments

### Scale Down / Up

This has to be done through the deployment in the helm chart. Another way to do it is to scale down

```
num=0

kubectl scale --replicas=${num} -n <namespace> deployment/<deploymentname>
```

## Nodes

Restarting nodes may need to happen if you need to change the size of the
instance, the machine's disk gets full, or you need to update a new AMI.  The
following code provides the howto.

### EKS


```
export AWS_PROFILE=aws_profile
export KUBECONFIG=./kubeconfig

for i in $(kubectl get nodes | awk '{print $1}' | grep -v NAME)
do
        kubectl drain --ignore-daemonsets --grace-period=60 --timeout=30s --force $i
        aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances --filter "Name=private-dns-name,Values=${i}" | jq -r '.Reservations[].Instances[].InstanceId')
        sleep 300 # Wait 5 mins for the new machine to come back up
done
```
