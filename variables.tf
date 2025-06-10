###############################################################
#   _  _  ___ ___     _                        ___ _  ___   __
#  | \| |/ __|_  )__ /_\   ____  _ _ _ ___ ___| __| \| \ \ / /
#  | .` | (__ / /___/ _ \ |_ / || | '_/ -_)___| _|| .` |\ V / 
#  |_|\_|\___/___| /_/ \_\/__|\_,_|_| \___|   |___|_|\_| \_/  
###############################################################
#
# Author: Jonas Werner
# Date: 2025/06/10 (yyyy/mm/dd)
# Version: 1.0.0
# Web: https://jonamiki.com
# Description: Variable definitions for Azure NC2 resources deployment
#              This file contains all variable declarations used in the deployment
#

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "public_ip_allocation_method" {
  description = "Public IP Allocation Method"
  type        = string
  default     = "Static"
}

variable "public_ip_sku" {
  description = "Public IP SKU"
  type        = string
  default     = "Standard"
}

variable "vpn_gateway_sku" {
  description = "VPN Gateway SKU"
  type        = string
  default     = "VpnGw2"
}

variable "bgp_asn" {
  description = "BGP ASN"
  type        = number
  default     = 65515
}

variable "local_network_gateway_address" {
  description = "Public IP address of the on-premises VPN device"
  type        = string
}

variable "address_space" {
  description = "Address space for the local network"
  type        = list(string)
}

variable "dns_servers" {
  description = "DNS Servers"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "hub_vnet_cidr" {
  description = "CIDR for the Hub Virtual Network"
  type        = string
  default     = "10.240.0.0/22"
}

variable "hub_default_subnet_cidr" {
  description = "CIDR for the Hub Default Subnet"
  type        = string
  default     = "10.240.0.0/24"
}

variable "hub_ars_subnet_cidr" {
  description = "CIDR for the Route Server Subnet"
  type        = string
  default     = "10.240.1.0/24"
}

variable "hub_nat_subnet_cidr" {
  description = "CIDR for the Hub NAT Subnet"
  type        = string
  default     = "10.240.2.0/24"
}

variable "gateway_subnet_cidr" {
  description = "CIDR for the Gateway Subnet"
  type        = string
  default     = "10.240.3.0/24"
}

variable "fgw_vnet_cidr" {
  description = "CIDR for the Flow GW Virtual Network"
  type        = string
  default     = "10.240.4.0/22"
}

variable "clstr_vnet_cidr" {
  description = "CIDR for the Cluster Virtual Network"
  type        = string
  default     = "10.240.8.0/22"
}

variable "pc_vnet_cidr" {
  description = "CIDR for the PC Virtual Network"
  type        = string
  default     = "10.240.12.0/22"
}

variable "vpn_shared_key" {
  description = "Shared key for the VPN connection"
  type        = string
  default     = "WfSJI\u0026Z@I\u003ezG8$+7C)5$-ljH\u00260FE[7xn"
}

variable "hub_vnet_address_space" {
  description = "Address space for the Hub Virtual Network"
  type        = list(string)
  default     = ["10.240.0.0/22"]
}

variable "fgw_vnet_address_space" {
  description = "Address space for the Flow GW Virtual Network"
  type        = list(string)
  default     = ["10.240.4.0/22"]
}

variable "clstr_vnet_address_space" {
  description = "Address space for the Cluster Virtual Network"
  type        = list(string)
  default     = ["10.240.8.0/22"]
}

variable "pc_vnet_address_space" {
  description = "Address space for the PC Virtual Network"
  type        = list(string)
  default     = ["10.240.12.0/22"]
} 
