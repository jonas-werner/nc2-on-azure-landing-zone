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
# Description: VPN Gateway configuration for Azure NC2 resources
#              This file sets up the VPN Gateway and related resources
#

resource "azurerm_public_ip" "vpn_gateway_pip" {
  name                = "vpn-gateway-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = "vpn-gateway"
  resource_group_name = var.resource_group_name
  location            = var.location
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = true
  sku                 = var.vpn_gateway_sku

  ip_configuration {
    name                          = "vpnGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn_gateway_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }

  bgp_settings {
    asn = var.bgp_asn
  }
}

resource "azurerm_local_network_gateway" "local_network_gateway" {
  name                = "local-network-gateway"
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = var.local_network_gateway_address
  address_space       = var.address_space

  bgp_settings {
    asn                 = var.bgp_asn
    bgp_peering_address = var.local_network_gateway_address
  }
}

resource "azurerm_virtual_network_gateway_connection" "vpn_connection" {
  name                       = "vpn-connection"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway.id
  shared_key                 = var.vpn_shared_key
  enable_bgp                 = true
}
