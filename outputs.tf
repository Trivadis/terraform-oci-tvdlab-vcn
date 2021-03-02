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

output "vcn_id" {
  description = "id of VCNs which are created"
  value       = oci_core_vcn.vcn.*.id
}

output "internet_gateway_id" {
  description = "OCID of internet gateway, if it is created"
  value       = oci_core_internet_gateway.igw.*.id
}

output "igw_route_id" {
  description = "OCID of internet gateway route table, if it is created"
  value       = oci_core_default_route_table.default_route_table.*.id
}

output "nat_gateway_id" {
  description = "OCID of nat gateway , if it is created"
  value       = oci_core_nat_gateway.natgw.*.id
}

output "nat_route_id" {
  description = "OCID of VCN NAT gateway route table, if it is created"
  value       = oci_core_route_table.private_route_table.*.id
}

output "default_dhcp_options_id" {
  description = "OCID of default DHCP options. "
  value       = oci_core_vcn.vcn.*.default_dhcp_options_id
}

output "private_dhcp_option_id" {
  description = "OCID of private DHCP options. "
  value       = oci_core_dhcp_options.private_dhcp_option.*.id
}

output "default_security_list_id" {
  description = "OCID of default security list. "
  value       = oci_core_vcn.vcn.*.default_security_list_id
}

output "public_subnet_id" {
  description = "OCIDs of public subnet in VCN. "
  value       = oci_core_subnet.public_subnet.*.id
}

output "private_subnet_id" {
  description = "OCIDs of private subnet in VCN. "
  value       = oci_core_subnet.private_subnet.*.id
}
# --- EOF -------------------------------------------------------------------
