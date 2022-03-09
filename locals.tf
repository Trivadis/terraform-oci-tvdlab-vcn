# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
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
  ssh_port      = 22
  http_port     = 80
  https_port    = 443
  openvpn_port  = 1194
  rdp_port      = 3389
  mosh_port     = 6000
  ingress_rule_ssh = [{
    port        = var.public_ssh_port
    protocol    = local.tcp_protocol
    description = "Allow inbound SSH traffic"
  }]
  ingress_rule_vpn = [{
    port = var.public_vpn_port
    #protocol    = local.udp_protocol
    protocol    = local.tcp_protocol
    description = "Allow inbound OpenVPN traffic"
  }]
  ingress_rule_http = [{
    port        = var.public_https_port
    protocol    = local.tcp_protocol
    description = "Allow inbound HTTPS traffic"
    },
    {
      port        = var.public_http_port
      protocol    = local.tcp_protocol
      description = "Allow inbound HTTPS traffic"
  }]

  ingress_rule_mosh = [{
    port        = var.public_mosh_port
    protocol    = local.tcp_protocol
    description = "Allow inbound MOSH traffic"
  }]

  ingress_rules = concat([],
    var.public_ssh_access == true ? local.ingress_rule_ssh : [],
    var.public_http_access == true ? local.ingress_rule_http : [],
    var.public_vpn_access == true ? local.ingress_rule_vpn : [],
  var.public_mosh_access == true ? local.ingress_rule_mosh : [])

  anywhere            = "0.0.0.0/0"
  resource_name       = var.resource_name == "" ? data.oci_identity_compartment.compartment.name : var.resource_name
  resource_shortname  = lower(replace(local.resource_name, "-", ""))
  public_dns_label    = "public"
  private_dns_label   = "private"
  default_private_dns = cidrhost(cidrsubnet(var.vcn_cidr, var.private_newbits, var.private_netnum), var.tvd_dns_hostnum)
  tvd_private_dns     = var.tvd_private_dns == "default" ? local.default_private_dns : var.tvd_private_dns
  custom_dns_servers  = var.custom_dns_servers == [] ? [local.tvd_private_dns, var.tvd_public_dns] : var.custom_dns_servers
}
# --- EOF -------------------------------------------------------------------
