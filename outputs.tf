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
  description = "ocid of created VCN. "
  value       = "${oci_core_vcn.*.id}"
}

output "default_security_list_id" {
  description = "ocid of default security list. "
  value       = "${oci_core_vcn.*.default_security_list_id}"
}

output "default_dhcp_options_id" {
  description = "ocid of default DHCP options. "
  value       = "${oci_core_vcn.*.default_dhcp_options_id}"
}

output "default_route_table_id" {
  description = "ocid of default route table. "
  value       = "${oci_core_vcn.*.default_route_table_id}"
}

output "internet_gateway_id" {
  description = "ocid of internet gateway. "
  value       = "${oci_core_internet_gateway.*.id}"
}

output "subnet_ids" {
  description = "ocid of subnet ids. "
  value       = "${oci_core_subnet.this.*.id}"
}

# --- EOF -------------------------------------------------------------------