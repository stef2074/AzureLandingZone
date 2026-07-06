variable "management_subscription_id" {
  description = "Azure subscription ID used for the Management subscription."
  type        = string
}

variable "tenant_root_group_id" {
  description = "Management Group ID of the existing Azure Tenant Root Group."
  type        = string
}
