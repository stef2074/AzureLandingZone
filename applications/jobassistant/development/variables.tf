variable "development_subscription_id" {
  description = "Azure subscription ID used for the Development subscription."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group used for the JobAssistant application."
  type        = string
}

variable "location" {
  description = "Azure region where JobAssistant application resources are deployed."
  type        = string
}