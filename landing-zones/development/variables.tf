variable "development_subscription_id" {
  description = "Azure subscription ID used for the Development subscription."
  type        = string
}

variable "connectivity_subscription_id" {
  description = "Azure subscription ID used for the Connectivity subscription."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group used for Development Landing Zone resources."
  type        = string
}

variable "connectivity_resource_group_name" {
  description = "Name of the resource group used for Platform Connectivity resources."
  type        = string
}

variable "location" {
  description = "Azure region where Development Landing Zone resources are deployed."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Development Landing Zone virtual network."
  type        = string
}

variable "hub_virtual_network_name" {
  description = "Name of the Platform Connectivity virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space for the Development Landing Zone virtual network."
  type        = string
}

variable "development_subnet_name" {
  description = "Name of the Development subnet."
  type        = string
}

variable "development_subnet_address_prefix" {
  description = "Address prefix for the Development subnet."
  type        = string
}

variable "network_security_group_name" {
  description = "Name of the network security group used for Development Landing Zone resources."
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table used for Development Landing Zone resources."
  type        = string
}

variable "hub_to_development_peering_name" {
  description = "Name of the virtual network peering from the Platform Connectivity hub to the Development Landing Zone."
  type        = string
}

variable "development_to_hub_peering_name" {
  description = "Name of the virtual network peering from the Development Landing Zone to the Platform Connectivity hub."
  type        = string
}