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
# Description: VNet peering configuration for Azure NC2 resources
#              This file sets up VNet peering between the Hub and other VNets
#

resource "azurerm_virtual_network_peering" "hub_to_fgw" {
  name                         = "hub-to-fgw"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.fgw.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "fgw_to_hub" {
  name                         = "fgw-to-hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.fgw.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true
}

resource "azurerm_virtual_network_peering" "hub_to_clstr" {
  name                         = "hub-to-clstr"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.clstr.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "clstr_to_hub" {
  name                         = "clstr-to-hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.clstr.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true
}

resource "azurerm_virtual_network_peering" "hub_to_pc" {
  name                         = "hub-to-pc"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.pc.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "pc_to_hub" {
  name                         = "pc-to-hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.pc.name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true
}

resource "azurerm_virtual_network_peering" "fgw_to_clstr" {
  name                         = "fgw-to-clstr"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.fgw.name
  remote_virtual_network_id    = azurerm_virtual_network.clstr.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "clstr_to_fgw" {
  name                         = "clstr-to-fgw"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.clstr.name
  remote_virtual_network_id    = azurerm_virtual_network.fgw.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "fgw_to_pc" {
  name                         = "fgw-to-pc"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.fgw.name
  remote_virtual_network_id    = azurerm_virtual_network.pc.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "pc_to_fgw" {
  name                         = "pc-to-fgw"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.pc.name
  remote_virtual_network_id    = azurerm_virtual_network.fgw.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
