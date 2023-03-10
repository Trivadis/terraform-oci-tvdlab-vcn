# ---------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: security.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Define security lists for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# create default security list
resource "oci_core_default_security_list" "default_security_list" {
  count                      = var.tvd_participants
  manage_default_resource_id = oci_core_vcn.vcn[count.index].default_security_list_id
  display_name               = var.label_prefix == "none" ? format("${local.resource_shortname}%02d default security list", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d default security list", count.index)

  # conditionally configure egress rules
  dynamic "egress_security_rules" {
    for_each = local.engress_rules

    content {
      description = egress_security_rules.value.description
      protocol    = egress_security_rules.value.protocol
      destination = local.anywhere

      tcp_options {
        min = egress_security_rules.value.min
        max = egress_security_rules.value.max
      }
    }
  }
  # conditionally configure ingress rules
  dynamic "ingress_security_rules" {
    for_each = local.ingress_rules

    content {
      description = ingress_security_rules.value.description
      protocol    = ingress_security_rules.value.protocol
      source      = local.anywhere

      tcp_options {
        min = ingress_security_rules.value.port
        max = ingress_security_rules.value.port
      }
    }
  }

  egress_security_rules {
    description = "Allow outbound DNS traffic"
    destination = local.anywhere
    protocol    = local.udp_protocol
    udp_options {
      min = local.dns_port
      max = local.dns_port
    }
  }

  # Allow RDP traffic in subnets
  egress_security_rules {
    description = "Allow all traffic in private subnet"
    destination = var.vcn_cidr
    protocol    = local.all_protocols
  }

  # default
  ingress_security_rules {
    protocol = local.icmp_protocol
    source   = local.anywhere

    icmp_options {
      code = 11
      type = 3
    }
  }

  # allow all internal traffic in private subnet
  ingress_security_rules {
    description = "Allow all traffic in private subnet"
    protocol    = local.all_protocols
    source      = var.vcn_cidr
  }

  # allow all internal traffic in private subnet
  ingress_security_rules {
    description = "Allow all traffic in private subnet"
    protocol    = local.all_protocols
    source      = cidrsubnet(var.vcn_cidr, var.private_newbits, var.private_netnum)
  }

  # Allow ICMP traffic locally
  ingress_security_rules {
    description = "Allow ICMP traffic locally not sure"
    protocol    = local.icmp_protocol
    source      = var.vcn_cidr
  }
}
# --- EOF -------------------------------------------------------------------
