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

variable "github_repository_name" {
  description = "GitHub repository name used by the federated identity credential."
  type        = string
}

variable "github_environment_name" {
  description = "GitHub Environment name used by the federated identity credential."
  type        = string
}