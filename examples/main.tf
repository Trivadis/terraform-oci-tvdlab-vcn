# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: main.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Main file to use terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "3.96.0"
    }
  }
}

# define the terraform provider
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

module "tvdlab-vcn" {
  source  = "Trivadis/tvdlab-vcn/oci"
  version = ">= 2.0.0"

  # - Mandatory Parameters --------------------------------------------------
  region         = var.region
  compartment_id = var.compartment_id

  # - Optional Parameters ---------------------------------------------------
  # Lab Configuration
  resource_name    = var.resource_name
  tvd_domain       = var.tvd_domain
  tvd_participants = var.tvd_participants

  # general oci parameters
  label_prefix = var.label_prefix
  tags         = var.tags

  # VCN Network parameter
  nat_gateway_enabled      = var.nat_gateway_enabled
  internet_gateway_enabled = var.internet_gateway_enabled
  service_gateway_enabled  = var.service_gateway_enabled
  vcn_cidr                 = var.vcn_cidr
  private_netnum           = var.private_netnum
  private_newbits          = var.private_newbits
  public_netnum            = var.public_netnum
  public_newbits           = var.public_newbits

  # Trivadis LAB specific parameter 
  tvd_dns_hostnum    = var.tvd_dns_hostnum
  custom_dns_servers = var.custom_dns_servers
  tvd_private_dns    = var.tvd_private_dns
  tvd_public_dns     = var.tvd_public_dns

  # Configure Public Access e.g. does create corresponding ingress rules
  public_ssh_access  = var.public_ssh_access
  public_ssh_port    = var.public_ssh_port
  public_http_access = var.public_http_access
  public_http_port   = var.public_http_port
  public_https_port  = var.public_https_port
  public_vpn_access  = var.public_vpn_access
  public_vpn_port    = var.public_vpn_port
  public_mosh_access = var.public_mosh_access
  public_mosh_port   = var.public_mosh_port
}
# --- EOF -------------------------------------------------------------------
