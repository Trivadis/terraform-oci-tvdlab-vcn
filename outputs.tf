# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: outputs.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Outputs defined for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------
# Modified...:
# see git revision history for more information on changes/updates
# ---------------------------------------------------------------------------

# get lab compartment resource information
output "vcn_id" {
  description = "id of vcns which are created"
  value       = oci_core_vcn.vcn.*.id
}

# output "nat_gateway_id" {
#   description = "id of nat gateway if it is created"
#   value       = join(",", oci_core_nat_gateway.nat_gateway.*.id)
# }

output "internet_gateway_id" {
  description = "id of internet gateway if it is created"
  value = join(",", oci_core_internet_gateway.igw.*.id)
}

# output "ig_route_id" {
#   description = "id of internet gateway route table"
#   value       = join(",", oci_core_route_table.ig.*.id)
# }

# output "nat_route_id" {
#   description = "id of VCN NAT gateway route table"
#   value       = join(",", oci_core_route_table.nat.*.id)
# }

output "default_security_list_id" {
  description = "ocid of default security list. "
  value       = oci_core_vcn.vcn.*.default_security_list_id
}

output "default_dhcp_options_id" {
  description = "ocid of default DHCP options. "
  value       = oci_core_vcn.vcn.*.default_dhcp_options_id
}

output "default_route_table_id" {
  description = "ocid of default route table. "
  value       = oci_core_vcn.vcn.*.default_route_table_id
}

# output "subnet_ids" {
#   description = "ocid of subnet ids. "
#   value       = "${oci_core_subnet.vcn.*.id}"
# }

# --- EOF -------------------------------------------------------------------