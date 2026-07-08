variable "tenant_root_group_id" {
  description = "Management Group ID of the existing Azure Tenant Root Group."
  type        = string
}

variable "management_subscription_id" {
  description = "Azure subscription ID assigned to the Management Management Group."
  type        = string
}

variable "connectivity_subscription_id" {
  description = "Azure subscription ID assigned to the Connectivity Management Group."
  type        = string
}

variable "development_subscription_id" {
  description = "Azure subscription ID assigned to the Development Management Group."
  type        = string
}
