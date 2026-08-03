variable "management_subscription_id" {
  description = "Azure subscription id used for the Management subscription."
  type        = string
}

variable "connectivity_subscription_id" {
  description = "Azure subscription id used for the Connectivity subscription."
  type        = string
}

variable "development_subscription_id" {
  description = "Azure subscription id used for the Development subscription."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group used for monitoring resources."
  type        = string
}

variable "location" {
  description = "Azure region where monitoring resources are deployed."
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "Name of the log analytics workspace."
  type        = string
}

variable "log_analytics_workspace_sku" {
  description = "Pricing sku of the log analytics workspace."
  type        = string
}

variable "log_analytics_workspace_retention_in_days" {
  description = "Data retention period for the log analytics workspace."
  type        = number
}

variable "management_activity_log_diagnostic_setting_name" {
  description = "Name of the Management subscription activity log diagnostic setting."
  type        = string
}

variable "connectivity_activity_log_diagnostic_setting_name" {
  description = "Name of the Connectivity subscription activity log diagnostic setting."
  type        = string
}

variable "development_activity_log_diagnostic_setting_name" {
  description = "Name of the Development subscription activity log diagnostic setting."
  type        = string
}