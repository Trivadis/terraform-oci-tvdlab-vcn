# ---------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: subnets.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@accenture.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Define subnets for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# create public subnet ------------------------------------------------------
resource "oci_core_subnet" "public_subnet" {
  count             = var.internet_gateway_enabled == true ? var.numberOf_labs : 0
  compartment_id    = var.compartment_id
  cidr_block        = cidrsubnet(var.vcn_cidr, var.public_newbits, var.public_netnum)
  display_name      = var.label_prefix == "none" ? format("${local.resource_shortname}%02d public subnet", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d public subnet", count.index)
  dns_label         = local.public_dns_label
  vcn_id            = oci_core_vcn.vcn[count.index].id
  security_list_ids = [oci_core_vcn.vcn[count.index].default_security_list_id]
  route_table_id    = oci_core_vcn.vcn[count.index].default_route_table_id
  dhcp_options_id   = oci_core_vcn.vcn[count.index].default_dhcp_options_id
}

# create private subnet -----------------------------------------------------
resource "oci_core_subnet" "private_subnet" {
  count                      = var.nat_gateway_enabled == true ? var.numberOf_labs : 0
  compartment_id             = var.compartment_id
  cidr_block                 = cidrsubnet(var.vcn_cidr, var.private_newbits, var.private_netnum)
  display_name               = var.label_prefix == "none" ? format("${local.resource_shortname}%02d private subnet", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d private subnet", count.index)
  dns_label                  = local.private_dns_label
  prohibit_public_ip_on_vnic = true
  vcn_id                     = oci_core_vcn.vcn[count.index].id
  security_list_ids          = [oci_core_vcn.vcn[count.index].default_security_list_id]
  route_table_id             = oci_core_route_table.private_route_table[count.index].id
  dhcp_options_id            = oci_core_dhcp_options.private_dhcp_option[count.index].id
}
# --- EOF -------------------------------------------------------------------
