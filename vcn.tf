# ---------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: vcn.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@accenture.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Define VCN resources for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# VCN resource --------------------------------------------------------------
resource "oci_core_vcn" "vcn" {
  count          = var.tvd_participants
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? format("${local.resource_shortname}%02d", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d", count.index)
  dns_label      = format("${local.resource_shortname}%02d", count.index)
  freeform_tags  = var.tags
}

# create public DHCP option -------------------------------------------------
resource "oci_core_default_dhcp_options" "public_dhcp_option" {
  count                      = var.tvd_participants
  manage_default_resource_id = oci_core_vcn.vcn[count.index].default_dhcp_options_id
  display_name               = var.label_prefix == "none" ? format("${local.resource_shortname}%02d public dhcp", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d public dhcp", count.index)

  options {
    custom_dns_servers = []
    server_type        = "VcnLocalPlusInternet"
    type               = "DomainNameServer"
  }

  options {
    search_domain_names = [
      format("${local.resource_shortname}%02d.oraclevcn.com", count.index),
    ]
    type = "SearchDomain"
  }
}

# create private DHCP option ------------------------------------------------
resource "oci_core_dhcp_options" "private_dhcp_option" {
  count          = var.tvd_participants
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn[count.index].id
  display_name   = var.label_prefix == "none" ? format("${local.resource_shortname}%02d private dhcp", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d private dhcp", count.index)

  # domain names server
  options {
    type               = "DomainNameServer"
    server_type        = "CustomDnsServer"
    custom_dns_servers = local.custom_dns_servers
  }

  # search domain
  options {
    type                = "SearchDomain"
    search_domain_names = [var.tvd_domain]
  }
}

# create the internet gateway resource --------------------------------------
resource "oci_core_internet_gateway" "igw" {
  count          = var.internet_gateway_enabled == true ? var.tvd_participants : 0
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? format("${local.resource_shortname}%02d_igw", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d_igw", count.index)

  vcn_id        = oci_core_vcn.vcn[count.index].id
  enabled       = "true"
  freeform_tags = var.tags
}

# create a default routing table --------------------------------------------
resource "oci_core_default_route_table" "default_route_table" {
  count                      = var.internet_gateway_enabled == true ? var.tvd_participants : 0
  display_name               = var.label_prefix == "none" ? format("${local.resource_shortname}%02d internet route", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d internet route", count.index)
  manage_default_resource_id = oci_core_vcn.vcn[count.index].default_route_table_id
  freeform_tags              = var.tags

  route_rules {
    destination       = local.anywhere
    network_entity_id = oci_core_internet_gateway.igw[count.index].id
  }
}
# --- EOF -------------------------------------------------------------------
