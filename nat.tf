# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: nat.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Define NAT resources for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------


# create the nat gateway resource -------------------------------------------
resource "oci_core_nat_gateway" "natgw" {
  count          = var.nat_gateway_enabled == true ? var.tvd_participants : 0
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? format("${local.resource_shortname}%02d_natgw", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d_natgw", count.index)
  vcn_id         = oci_core_vcn.vcn.*.id[count.index]
  block_traffic  = false
  freeform_tags  = var.tags
}

# create a default routing table --------------------------------------------
resource "oci_core_route_table" "private_route_table" {
  count          = var.nat_gateway_enabled == true ? var.tvd_participants : 0
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? format("${local.resource_shortname}%02d private route", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d private route", count.index)
  vcn_id         = oci_core_vcn.vcn.*.id[count.index]
  freeform_tags  = var.tags

  route_rules {
    destination       = local.anywhere
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.natgw.*.id[count.index]
  }
  dynamic "route_rules" {
    for_each = var.service_gateway_enabled == true ? list(1) : []

    content {
      destination       = lookup(data.oci_core_services.all_oci_services[0].services[0], "cidr_block")
      destination_type  = "SERVICE_CIDR_BLOCK"
      network_entity_id = oci_core_service_gateway.service_gateway[0].id
    }
  }
}
# --- EOF -------------------------------------------------------------------
