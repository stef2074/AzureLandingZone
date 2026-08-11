variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string
}

variable "development_subscription_id" {
  description = "Azure subscription ID used for the Development subscription."
  type        = string
}

variable "github_actions_application_name" {
  description = "Name of the Microsoft Entra Application used by JobAssistant GitHub Actions."
  type        = string
}

variable "github_repository_owner" {
  description = "GitHub repository owner used by the federated identity credential."
  type        = string
}

variable "github_repository_owner_id" {
  description = "GitHub repository owner ID used by the federated identity credential."
  type        = string
}

variable "github_repository_name" {
  description = "GitHub repository name used by the federated identity credential."
  type        = string
}

variable "github_repository_id" {
  description = "GitHub repository ID used by the federated identity credential."
  type        = string
}

variable "github_environment_name" {
  description = "GitHub Environment name used by the federated identity credential."
  type        = string
}

variable "jobassistant_resource_group_name" {
  description = "Name of the Resource Group used for the JobAssistant application."
  type        = string
}
