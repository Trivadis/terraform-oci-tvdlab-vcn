# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: variables.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Variable file for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------
# Modified...:
# see git revision history for more information on changes/updates
# ---------------------------------------------------------------------------

# provider identity parameters
variable "region" {
    # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
    description = "The OCI region where resources will be created"
    type        = string
}

# general oci parameters
variable "compartment_id" {
    description = "OCID of the tcompartment where to create all resources"
    type        = string
}

variable "label_prefix" {
    description = "A string that will be prepended to all resources"
    type        = string
    default     = "none"
}

# vcn parameters
variable "internet_gateway_enabled" {
    description = "whether to create the internet gateway"
    default     = true
    type        = bool
}

variable "nat_gateway_enabled" {
    description = "whether to create a nat gateway in the vcn"
    default     = true
    type        = bool
}

variable "service_gateway_enabled" {
    description = "whether to create a service gateway"
    default     = false
    type        = bool
}

variable "vcn_cidr" {
    description = "cidr block of VCN"
    default     = "10.0.0.0/16"
    type        = string
}

variable "vcn_name" {
    description = "user-friendly name of to use for the vcn to be appended to the label_prefix"
    type        = string
}

# public/bastion subnet
variable "public_netnum" {
  description = "0-based index of the bastion subnet when the VCN's CIDR is masked with the corresponding newbit value."
  default     = 0
  type        = number
}

variable "public_newbits" {
  description = "The difference between the VCN's netmask and the desired bastion subnet mask"
  default     = 8
  type        = number
}

variable "public_dns_label" {
    description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
    default     = "public"
    type        = string
}

# private subnet
variable "private_netnum" {
  description = "0-based index of the private subnet when the VCN's CIDR is masked with the corresponding newbit value."
  default     = 1
  type        = number
}

variable "private_newbits" {
  description = "The difference between the VCN's netmask and the desired private subnet mask"
  default     = 8
  type        = number
}

variable "private_dns_label" {
    description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
    default     = "private"
    type        = string
}

variable "tags" {
  description = "simple key-value pairs to tag the resources created"
  type        = map(any)
  default = {
    environment = "dev"
  }
}

# Trivadis LAB specific parameter
variable "tvd_participants" {
    description = "The number of VCNs to create"
    type        = number
    default     = 1
}

variable "tvd_domain" {   
    description = "The domain name of the LAB environment"
    type        = string
    default     = "trivadislabs.com" 
}

variable "tvd_dns_hostnum" {   
    description = "The host number for the Trivadis LAB DNS server. This number is used to build the IP address using cidrhost function"
    type        = number
    default     = 4
}

variable "tvd_private_dns" {   
    description = "A private DNS IP address for the training environment"
    type        = string
    default     = "default" 
}

variable "tvd_public_dns" {   
    description = "A public DNS IP address for the training environment"
    type        = string
    default     = "8.8.8.8" 
}
# --- EOF -------------------------------------------------------------------