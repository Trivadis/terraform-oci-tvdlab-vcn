# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: logging.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Define OCI Log Group for private subnet.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------


# create the log group -------------------------------------------
resource "oci_logging_log_group" "log_group" {
  count          = var.tvd_participants
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? format("${local.resource_shortname}%02d_lg", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d_lg", count.index)
  freeform_tags  = var.tags
}

# create a default log --------------------------------------------
resource "oci_logging_log" "default_log" {
  count        = var.tvd_participants
  display_name = var.label_prefix == "none" ? format("${local.resource_shortname}%02d_log", count.index) : format("${var.label_prefix} ${local.resource_shortname}%02d_log", count.index)
  log_group_id = oci_logging_log_group.log_group.*.id[count.index]
  log_type     = var.log_type

  configuration {
    source {
      category    = var.log_configuration_source_category
      resource    = oci_core_subnet.private_subnet.*.id[count.index]
      service     = var.log_configuration_source_service
      source_type = var.log_configuration_source_source_type
    }

    compartment_id = var.compartment_id
  }
  freeform_tags      = var.tags
  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration
}
# --- EOF -------------------------------------------------------------------
