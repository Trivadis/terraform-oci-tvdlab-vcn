# ---------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: variables.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@accenture.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Variable definition file for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# provider identity parameters ----------------------------------------------
variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The OCI region where resources will be created"
  type        = string
}

# general oci parameters ----------------------------------------------------
variable "compartment_id" {
  description = "OCID of the compartment where to create all resources"
  type        = string
}

variable "label_prefix" {
  description = "A string that will be prepended to all resources"
  type        = string
  default     = "none"
}

variable "resource_name" {
  description = "user-friendly string to name all resource. If undefined it will be derived from compartment name. "
  type        = string
  default     = ""
}

variable "tags" {
  description = "A simple key-value pairs to tag the resources created"
  type        = map(any)
  default     = {}
}

# VCN parameters ------------------------------------------------------------
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

# Public Subnet parameters --------------------------------------------------
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

variable "inbound_ssh_access" {
  description = "Flag indicating whether public SSH access is to be granted, or not."
  default     = true
  type        = bool
}

variable "inbound_ssh_port" {
  description = "Public SSH access port configured in security list."
  type        = number
  default     = 22
}

variable "inbound_http_access" {
  description = "Flag indicating whether inbound HTTP/HTTPS access is to be granted, or not."
  default     = true
  type        = bool
}

variable "inbound_http_port" {
  description = "Inbound HTTP access port configured in security list."
  type        = number
  default     = 80
}

variable "inbound_https_port" {
  description = "Inbound HTTPS access port configured in security list."
  type        = number
  default     = 443
}

variable "outbound_http_access" {
  description = "Flag indicating whether outbound HTTP/HTTPS access is to be granted, or not."
  default     = true
  type        = bool
}

variable "outbound_http_port" {
  description = "Outbound HTTP access port configured in security list."
  type        = number
  default     = 80
}

variable "outbound_https_port" {
  description = "Outbound HTTPS access port configured in security list."
  type        = number
  default     = 443
}

variable "outbound_port_range" {
  description = "Flag indicating whether outbound TCP range access is to be granted, or not."
  default     = true
  type        = bool
}

variable "outbound_port_range_min" {
  description = "Outbound min port for TCP range access configured in security list."
  type        = number
  default     = 15000
}

variable "outbound_port_range_max" {
  description = "Outbound max port for TCP range access configured in security list."
  type        = number
  default     = 20999
}



variable "inbound_vpn_access" {
  description = "Flag indicating whether public OpenVPN access is to be granted, or not."
  default     = true
  type        = bool
}

variable "inbound_vpn_port" {
  description = "Inbound OpenVPN access port configured in security list."
  type        = number
  default     = 1194
}

variable "inbound_mosh_access" {
  description = "Flag indicating whether public MOSH access is to be granted, or not."
  default     = false
  type        = bool
}

variable "inbound_mosh_port" {
  description = "Inbound MOSH access port configured in security list."
  type        = number
  default     = 6000
}

# Private Subnet parameters -------------------------------------------------
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

# Trivadis LAB specific parameter -------------------------------------------
variable "numberOf_labs" {
  description = "Number of similar lab environments to be created. Default just one environment."
  type        = number
  default     = 1
}

variable "lab_domain" {
  description = "The domain name of the LAB environment"
  type        = string
  default     = "trivadislabs.com"
}

variable "lab_dns_hostnum" {
  description = "The host number for the Trivadis LAB DNS server. This number is used to build the IP address using cidrhost function"
  type        = number
  default     = 4
}

variable "custom_dns_servers" {
  description = "List of custom DNS server"
  type        = list(string)
  default     = []
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

# Log parameter -------------------------------------------------------------
variable "log_is_enabled" {
  description = "Whether or not this resource is currently enabled."
  default     = true
  type        = bool
}

variable "log_retention_duration" {
  description = "Log retention duration in 30-day increments (30, 60, 90 and so on)."
  type        = string
  default     = 90
}

variable "log_type" {
  description = "The logType that the log object is for, whether custom or service."
  type        = string
  default     = "SERVICE"
}

variable "log_configuration_source_category" {
  description = "Log object category."
  type        = string
  default     = "all"
}

variable "log_configuration_source_service" {
  description = "Service generating log."
  type        = string
  default     = "flowlogs"
}

variable "log_configuration_source_source_type" {
  description = "The log source."
  type        = string
  default     = "OCISERVICE"
}

# --- EOF -------------------------------------------------------------------
