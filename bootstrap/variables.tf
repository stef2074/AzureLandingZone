variable "management_subscription_id" {
  description = "Azure subscription ID used for the Management subscription."
  type        = string
}

variable "location" {
  description = "Azure region where the Terraform backend resources will be deployed."
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the Resource Group used for Terraform backend resources."
  type        = string
  default     = "rg-tfstate"
}

variable "storage_account_name" {
  description = "Globally unique name for the Terraform backend Storage Account."
  type        = string
}

variable "container_name" {
  description = "Name of the Blob Container used to store the Terraform state file."
  type        = string
  default     = "tfstate"
}
