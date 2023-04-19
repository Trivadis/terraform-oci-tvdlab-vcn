# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: datasource.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@accenture.com
# Editor.....: Stefan Oehrli
# Date.......: 2023.04.19
# Revision...: 
# Purpose....: Compute Instance for the terraform module tvdlab bastion.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

# get compartment information
data "oci_identity_compartment" "compartment" {
  id = var.compartment_id
}
# --- EOF ----------------------------------------------------------------------
