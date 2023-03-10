# ---------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: locals.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Local variables for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

locals {
  all_protocols = "all"
  icmp_protocol = 1
  tcp_protocol  = 6
  udp_protocol  = 17
  dns_port      = 53

  ingress_rule_ssh = [{
    port        = var.inbound_ssh_port
    protocol    = local.tcp_protocol
    description = "Allow inbound SSH traffic"
  }]
  ingress_rule_vpn = [{
    port        = var.inbound_vpn_port
    protocol    = local.tcp_protocol
    description = "Allow inbound OpenVPN traffic"
  }]
  ingress_rule_http = [{
    port        = var.inbound_https_port
    protocol    = local.tcp_protocol
    description = "Allow inbound HTTPS traffic"
    },
    {
      port        = var.inbound_http_port
      protocol    = local.tcp_protocol
      description = "Allow inbound HTTPS traffic"
  }]

  ingress_rule_mosh = [{
    port        = var.inbound_mosh_port
    protocol    = local.tcp_protocol
    description = "Allow inbound MOSH traffic"
  }]

  ingress_rules = concat([],
    var.inbound_ssh_access == true ? local.ingress_rule_ssh : [],
    var.inbound_http_access == true ? local.ingress_rule_http : [],
    var.inbound_vpn_access == true ? local.ingress_rule_vpn : [],
  var.inbound_mosh_access == true ? local.ingress_rule_mosh : [])

  egress_rule_http = [{
    min         = var.outbound_https_port
    max         = var.outbound_https_port
    protocol    = local.tcp_protocol
    description = "Allow outbound HTTPS traffic"
    },
    {
      min         = var.outbound_http_port
      max         = var.outbound_http_port
      protocol    = local.tcp_protocol
      description = "Allow outbound HTTP traffic"
  }]

  egress_rule_port_range = [{
    min         = var.outbound_port_range_min
    max         = var.outbound_port_range_max
    protocol    = local.tcp_protocol
    description = "Allow outbound TCP port range"
  }]

  engress_rules = concat([],
    var.outbound_port_range == true ? local.egress_rule_port_range : [],
  var.outbound_http_access == true ? local.egress_rule_http : [])

  anywhere            = "0.0.0.0/0"
  resource_name       = var.resource_name == "" ? data.oci_identity_compartment.compartment.name : var.resource_name
  resource_shortname  = lower(replace(local.resource_name, "-", ""))
  public_dns_label    = "public"
  private_dns_label   = "private"
  default_private_dns = cidrhost(cidrsubnet(var.vcn_cidr, var.private_newbits, var.private_netnum), var.tvd_dns_hostnum)
  tvd_private_dns     = var.tvd_private_dns == "default" ? local.default_private_dns : var.tvd_private_dns
  custom_dns_servers  = length(var.custom_dns_servers) == 0 ? [local.tvd_private_dns, var.tvd_public_dns] : var.custom_dns_servers
}
# --- EOF -------------------------------------------------------------------
