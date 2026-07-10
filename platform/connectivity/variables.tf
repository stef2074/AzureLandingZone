variable "connectivity_subscription_id" {
  description = "Azure subscription ID used for the Connectivity subscription."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group used for Platform Connectivity resources."
  type        = string
}

variable "location" {
  description = "Azure region where Platform Connectivity resources are deployed."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Platform Connectivity virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space for the Platform Connectivity virtual network."
  type        = string
}

variable "gateway_subnet_name" {
  description = "Name of the Gateway subnet."
  type        = string
}

variable "gateway_subnet_address_prefix" {
  description = "Address prefix for the Gateway subnet."
  type        = string
}

variable "shared_services_subnet_name" {
  description = "Name of the Shared Services subnet."
  type        = string
}

variable "shared_services_subnet_address_prefix" {
  description = "Address prefix for the Shared Services subnet."
  type        = string
}

variable "network_security_group_name" {
  description = "Name of the network security group used for Platform Connectivity resources."
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table used for Platform Connectivity resources."
  type        = string
}
