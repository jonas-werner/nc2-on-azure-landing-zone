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
# Description: Virtual Network configuration for Azure NC2 resources
#              This file sets up all virtual networks and their subnets
#

# Hub VNet
resource "azurerm_virtual_network" "hub" {
  name                = "hub-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.hub_vnet_address_space
  dns_servers         = var.dns_servers
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.hub_default_subnet_cidr]
}

resource "azurerm_subnet" "ars" {
  name                 = "ars"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.hub_ars_subnet_cidr]
}

resource "azurerm_subnet" "nat" {
  name                 = "nat"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.hub_nat_subnet_cidr]
}

resource "azurerm_subnet" "gateway" {
  name                 = "gateway"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.gateway_subnet_cidr]
}

# Flow GW VNet
resource "azurerm_virtual_network" "fgw" {
  name                = "fgw-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.fgw_vnet_address_space
  dns_servers         = var.dns_servers
}

# Cluster VNet
resource "azurerm_virtual_network" "clstr" {
  name                = "clstr-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.clstr_vnet_address_space
  dns_servers         = var.dns_servers
}

# PC VNet
resource "azurerm_virtual_network" "pc" {
  name                = "pc-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.pc_vnet_address_space
  dns_servers         = var.dns_servers
}

locals {
  fgw_external_subnet = [for s in azurerm_virtual_network.fgw.subnet : s if s.name == "FGWExternalSubnet"]
  clstr_subnet = [for s in azurerm_virtual_network.clstr.subnet : s if s.name == "CLSTRSubnet"]
  pc_subnet = [for s in azurerm_virtual_network.pc.subnet : s if s.name == "PCSubnet"]
  bgp_subnet = [for s in azurerm_virtual_network.fgw.subnet : s if s.name == "FGWBGPSubnet"]
}

