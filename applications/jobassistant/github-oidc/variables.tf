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