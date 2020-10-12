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
# Modified...:
# see git revision history for more information on changes/updates
# ---------------------------------------------------------------------------
# create default security list
resource "oci_core_default_security_list" "default_security_list" {
    count                       = var.tvd_participants
    manage_default_resource_id  = oci_core_vcn.vcn.*.default_security_list_id[count.index]
    display_name                = format(lower("${var.vcn_name}%02d default security list"), count.index)
    # allow outbound tcp traffic on all ports
    egress_security_rules {
        protocol    = local.all_protocols
        destination = local.anywhere
    }

    # allow inbound SSH traffic
    ingress_security_rules {
        description = "Allow inbound SSH traffic"
        protocol    = local.tcp_protocol
        source      = local.anywhere

        tcp_options {
            min = local.ssh_port
            max = local.ssh_port
        }
    }

    # allow inbound SSH traffic
    ingress_security_rules {
        description = "Allow RDP traffic in subnets"
        protocol = local.tcp_protocol
        source   = var.vcn_cidr

        tcp_options {
            min = local.rdp_port
            max = local.rdp_port
        }
    }

    # default
    ingress_security_rules {
        protocol    = local.icmp_protocol
        source      = local.anywhere

        icmp_options {
            code    = 4
            type    = 3
        }
    }

    # allow all internal traffic in private subnet
    ingress_security_rules {
        description = "Allow all traffic in private subnet"
        protocol    = local.all_protocols
        source      = var.vcn_cidr
    }

    # Allow ICMP traffic locally
    ingress_security_rules {
        description = "Allow ICMP traffic locally not sure"
        protocol    = local.icmp_protocol
        source      = var.vcn_cidr
    }
}
# --- EOF -------------------------------------------------------------------