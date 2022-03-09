# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
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
  manage_default_resource_id = oci_core_vcn.vcn.*.default_security_list_id[count.index]
  display_name               = var.label_prefix == "none" ? format("${local.resource_shortname}%02d default security list", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d default security list", count.index)

  # allow outbound tcp traffic on all ports
  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  # allow inbound SSH traffic
  ingress_security_rules {
    count       = var.public_ssh_access == true ? 1 : 0
    description = "Allow inbound SSH traffic"
    protocol    = local.tcp_protocol
    source      = local.anywhere

    tcp_options {
      min = var.public_ssh_port
      max = var.public_ssh_port
    }
  }

  # allow inbound HTTP traffic
  ingress_security_rules {
    count       = var.public_http_access == true ? 1 : 0
    description = "Allow inbound HTTP traffic"
    protocol    = local.tcp_protocol
    source      = local.anywhere

    tcp_options {
      min = var.public_http_port
      max = var.public_http_port
    }
  }

  # allow inbound HTTPS traffic
  ingress_security_rules {
    count       = var.public_http_access == true ? 1 : 0
    description = "Allow inbound HTTPS traffic"
    protocol    = local.tcp_protocol
    source      = local.anywhere

    tcp_options {
      min = var.public_https_port
      max = var.public_https_port
    }
  }

  # allow inbound OpenVPN traffic
  ingress_security_rules {
    count       = var.public_vpn_access == true ? 1 : 0
    description = "Allow inbound OpenVPN traffic"
    protocol    = local.udp_protocol
    source      = local.anywhere

    tcp_options {
      min = var.public_vpn_port
      max = var.public_vpn_port
    }
  }
  # allow inbound MOSH traffic
  ingress_security_rules {
    count       = var.public_mosh_access == true ? 1 : 0
    description = "Allow inbound MOSH traffic"
    protocol    = local.tcp_protocol
    source      = local.anywhere

    tcp_options {
      min = var.public_mosh_port
      max = var.public_mosh_port + 10
    }
  }

  # Allow RDP traffic in subnets
  ingress_security_rules {
    description = "Allow RDP traffic in subnets"
    protocol    = local.tcp_protocol
    source      = var.vcn_cidr

    tcp_options {
      min = local.rdp_port
      max = local.rdp_port
    }
  }

  # default
  ingress_security_rules {
    protocol = local.icmp_protocol
    source   = local.anywhere

    icmp_options {
      code = 4
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
