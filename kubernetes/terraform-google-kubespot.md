<!-- BEGIN_TF_DOCS -->
# Kubespot (GCP)

<img src="http://assets.opszero.com.s3.amazonaws.com/images/auditkube.png" width="200px" />

Compliance Oriented Kubernetes Setup for AWS, Google Cloud and Microsoft Azure.

Kubespot is an open source terraform module that attempts to create a complete
compliance-oriented Kubernetes setup on AWS, Google Cloud and Azure.  These add
additional security such as additional system logs, file system monitoring, hard
disk encryption and access control. Further, we setup the managed Redis and SQL
on each of the Cloud providers with limited access to the Kubernetes cluster so
things are further locked down. All of this should lead to setting up a HIPAA /
PCI / SOC2 being made straightforward and repeatable.

This covers how we setup your infrastructure on AWS, Google Cloud and Azure.
These are the three Cloud Providers that we currently support to run Kubernetes.
Further, we use the managed service provided by each of the Cloud Providers.
This document covers everything related to how infrastructure is setup within
each Cloud, how we create an isolated environment for Compliance and the
commonalities between them.

# Tools & Setup

```
brew install kubectl kubernetes-helm google-cloud-sdk terraform
```

# Credentials


# Network Diagram


## Releases

```sh
TAG=v3.0.1
gh release create $TAG --discussion-category "General"
```

# Support
<a href="https://www.opszero.com"><img src="http://assets.opszero.com.s3.amazonaws.com/images/opszero_11_29_2016.png" width="300px"/></a>

This project is by [opsZero](https://www.opszero.com). We help organizations
migrate to Kubernetes so [reach out](https://www.opszero.com/#contact) if you
need help!
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | n/a | `string` | `"1.21"` | no |
| <a name="input_csi_secrets_store_enabled"></a> [csi\_secrets\_store\_enabled](#input\_csi\_secrets\_store\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | n/a | `string` | n/a | yes |
| <a name="input_foxpass_api_key"></a> [foxpass\_api\_key](#input\_foxpass\_api\_key) | the following below are required for setting up the vpn | `string` | `""` | no |
| <a name="input_foxpass_vpn_psk"></a> [foxpass\_vpn\_psk](#input\_foxpass\_vpn\_psk) | use this for psk generation https://cloud.google.com/vpn/docs/how-to/generating-pre-shared-key | `string` | `""` | no |
| <a name="input_nodes_desired_capacity"></a> [nodes\_desired\_capacity](#input\_nodes\_desired\_capacity) | n/a | `number` | `1` | no |
| <a name="input_nodes_instance_type"></a> [nodes\_instance\_type](#input\_nodes\_instance\_type) | n/a | `string` | `"n1-standard-1"` | no |
| <a name="input_nodes_max_size"></a> [nodes\_max\_size](#input\_nodes\_max\_size) | n/a | `number` | `1` | no |
| <a name="input_nodes_min_size"></a> [nodes\_min\_size](#input\_nodes\_min\_size) | n/a | `number` | `1` | no |
| <a name="input_redis_enabled"></a> [redis\_enabled](#input\_redis\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_redis_ha_enabled"></a> [redis\_ha\_enabled](#input\_redis\_ha\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_redis_memory_in_gb"></a> [redis\_memory\_in\_gb](#input\_redis\_memory\_in\_gb) | n/a | `number` | `1` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-central1"` | no |
| <a name="input_sql_enabled"></a> [sql\_enabled](#input\_sql\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_sql_engine"></a> [sql\_engine](#input\_sql\_engine) | n/a | `string` | `"POSTGRES_13"` | no |
| <a name="input_sql_instance_class"></a> [sql\_instance\_class](#input\_sql\_instance\_class) | n/a | `string` | `"db-f1-micro"` | no |
| <a name="input_sql_master_password"></a> [sql\_master\_password](#input\_sql\_master\_password) | n/a | `string` | `""` | no |
| <a name="input_sql_master_username"></a> [sql\_master\_username](#input\_sql\_master\_username) | n/a | `string` | `""` | no |
## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_kms_crypto_key.key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_key_ring.keyring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_redis_instance.cache](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance) | resource |
| [google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_sql_database_instance.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [helm_release.csi_secrets_store](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [null_resource.csi_secrets_store_aws_provider](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.sql_vpc_lock](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.server](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [http_http.csi_secrets_store_gcp_provider](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_vpc_network"></a> [private\_vpc\_network](#output\_private\_vpc\_network) | n/a |
| <a name="output_sql_database"></a> [sql\_database](#output\_sql\_database) | n/a |
<!-- END_TF_DOCS -->