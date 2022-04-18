# Nodes

Restarting nodes may need to happen if you need to change the size of the
instance, the machine's disk gets full, or you need to update a new AMI.  The
following code provides the howto.

## EKS

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