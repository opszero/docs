# Terraform

The infrastructure is setup using Kubespot which is a Terraform module to
create the entire infrastructure. Terraform is used to create Infrastructure as
Code so you don’t have to go into the Consoles of the different environments and
point and click to build infrastructure.

opsZero setups the infrastructure using Terraform so that it can be built in a
repeatable manner. This grants you a couple benefits: it creates an audit trail
of changes to your infrastructure so you remain compliant, it allows you test
new infrastructure services quickly if you want to add them, it allows you to
create completely identical isolated environment across different Cloud
environments.

Our Terraform module creates the following across different modules: Kubernetes
Cluster, Bastion, VPN Machine, SQL (AWS Aurora, AWS RDS, Google Cloud SQL, Azure
Database for PostgreSQL), and Redis (AWS ElasticCache, Google MemoryStore, Azure
Redis), VPCs, Security Groups.

We setup a new Virtual Private Clouds (VPCs) that isolate the access in each
environment. This is beneficial in that even if you are using an existing Cloud
environment the VPC in which Kubernetes is deployed will be isolated from the
other networks unless it is opened up via VPC Peering. Also by having everything
within one VPC we can create and limit network flows to the required services.

Since Terraform is just code it allows us to check in all changes into Git to
create an audit trail. This audit trail and all changes to the infrastructure
need to be documented to remain compliant with HIPAA / PCI / SOC2.

The Bastion and VPN are two separate machines that have an external IP. These
are how we connect to the Kubernetes cluster as it requires we connect to the
VPN and then to the Bastion to have access to the Kubernetes cluster. We use
Foxpass for authentication to the Bastion and VPN. Foxpass allows you to use G
Suite and Office 365 to grant access to the machines giving a singular place for
access.

Terraform needs only be run when we create the infrastructure and when we want
to make changes to that infrastructure. The way terraform works is that it
creates the infrastructure and generates a statefile when you run terraform
apply. This file is the state of your infrastructure and should be checked in to
Git. Additional runs of terraform apply compares this statefile to what exists
in your infrastructure and creates, modifies or deletes based on what is in your
terraform .tf file and what your statefile shows.

The usual reasons you would run terraform are:

Change the number of nodes running in your cluster
Change the size of your database
Change the size of your redis
Add additional services to your infrastructure
AWS
The configuration for AWS looks something like this:

We build a completely independent VPC that is locked down. We lock things down by doing the following:

Need to use bastion for access. It uses Foxpass for access through G Suite, Microsoft 360, OKTA.
Need to use VPN for access to the bastion.
Need to use ELB via Ingress to Access Kubernetes Services
Additional Logging and Security Updates on Amazon Linux including OSSEC
Additional Control Log Flows
Node level Encryption
Google Cloud
Azure
