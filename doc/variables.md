# Module Variables

Variables for the configuration of the terraform module, defined in [variables](../variables.tf). Whereby the following are mandatory:

* `region` Region where to provision the VCN.
* `compartment_id` OCID of the compartment where to create all resources.

## Provider

| Parameter      | Description                                                                                                                                                        | Values | Default |
|----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------|---------|
| `region`       | Region where to provision the VCN. [List of regions](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm). Required when configuring provider. |        |         |

## General OCI

| Parameter        | Description                                                                           | Values | Default |
|------------------|---------------------------------------------------------------------------------------|--------|---------|
| `compartment_id` | OCID of the compartment where to create all resources.                                | OCID   |         |
| `label_prefix`   | A string that will be prepended to all resources.                                     |        | none    |
| `resource_name`  | A string to name all resource. If undefined it will be derived from compartment name. |        | n/a     |
| `tags`           | A simple key-value pairs to tag the resources created.                                |        |         |

## VCN Variables

| Parameter                  | Description                                                                                              | Values     | Default     |
|----------------------------|----------------------------------------------------------------------------------------------------------|------------|-------------|
| `internet_gateway_enabled` | Whether to create the internet gateway.                                                                  | true/false | true        |
| `nat_gateway_enabled`      | Whether to create the nat gateway in the vcn.                                                            | true/false | true        |
| `service_gateway_enabled`  | Whether to create a service gateway in the vcn.                                                          | true/false | false       |
| `vcn_cidr`                 | cidr block of VCN.                                                                                       |            | 10.0.0.0/16 |
| `public_netnum`            | 0-based index of the public subnet when the VCN's CIDR is masked with the corresponding *newbit* value.  |            | 0           |
| `public_newbits`           | The difference between the VCN's netmask and the desired public subnet mask.                             |            | 8           |
| `private_netnum`           | 0-based index of the private subnet when the VCN's CIDR is masked with the corresponding *newbit* value. |            | 1           |
| `private_newbits`          | The difference between the VCN's netmask and the desired private subnet mask.                            |            | 8           |

## Trivadis LAB

Specific parameter to configure the Trivadis LAB environment.

| Parameter          | Description                                                                                                                               | Values | Default          |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------------|--------|------------------|
| `tvd_participants` | The number of bastion resource to create. This is used to build several identical environments for a training and laboratory environment. |        | 1                |
| `tvd_domain`       | The domain name of the LAB environment. This is used to register the public IP address of the bastion host.                               |        | trivadislabs.com |
| `tvd_dns_hostnum`  | The host number for the Trivadis LAB DNS server. This number is used to build the IP address using cidrhost function.                     |        | 4                |
| `custom_dns_servers`  | List of DNS server for the private network. Default it use `tvd_private_dns` and `tvd_public_dns`         |        |           |
| `tvd_private_dns`  | A private DNS IP address for the training environment. Default means that it will be created based on `tvd_dns_hostnum`                   |        | default          |
| `tvd_public_dns`   | A public DNS IP address for the training environment.                                                                                     |        | 8.8.8.8          |

## Local Variables

| Parameter             | Description                                                                                 | Values | Default   |
|-----------------------|---------------------------------------------------------------------------------------------|--------|-----------|
| `all_protocols`       | All protocols.                                                                              |        | all       |
| `icmp_protocol`       | Number for the ICMP protocol.                                                               |        | 1         |
| `tcp_protocol`        | Number for the TCP protocol.                                                                |        | 6         |
| `ssh_port`            | SSH port.                                                                                   |        | 22        |
| `rdp_port`            | Remote desktop port.                                                                        |        | 3389      |
| `anywhere`            | CIDR block for anywhare.                                                                    |        | 0.0.0.0/0 |
| `tcp_protocol`        | Number for the TCP protocol.                                                                |        |           |
| `resource_name`       | Local variable containing either the value of `var.resource_name` or the compartment name.  |        |           |
| `resource_shortname`  | Short, lower case version of the `resource_name` variable.                                  |        |           |
| `public_dns_label`    | DNS label for the public subnet.                                                            |        | public    |
| `private_dns_label`   | DNS label for the private subnet.                                                           |        | private   |
| `default_private_dns` | Default private DNS. IP address is derivated from `var.vcn_cidr` and `var.tvd_dns_hostnum`. |        | 10.0.1.4  |
