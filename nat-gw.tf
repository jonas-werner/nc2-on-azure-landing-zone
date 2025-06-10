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
# Description: NAT Gateway configuration for Azure NC2 resources
#              This file sets up the NAT Gateway and related resources
#

resource "azurerm_public_ip" "nat_gateway_pip" {
  name                = "nat-gateway-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = "nat-gateway"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_pip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet_association" {
  subnet_id      = azurerm_subnet.nat.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}

# NAT Gateway for Flow GW VNet
resource "azurerm_nat_gateway" "fgw_nat_gateway" {
  name                = "FGW-NAT-GW"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  sku_name = "Standard"

  tags = {
    fastpathenabled = "true"
  }
}

resource "azurerm_public_ip" "fgw_nat_ip" {
  name                = "FGW-NAT-IP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_nat_gateway_public_ip_association" "fgw_nat_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.fgw_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.fgw_nat_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "fgw_nat_assoc" {
  subnet_id      = local.fgw_external_subnet[0].id  
  nat_gateway_id = azurerm_nat_gateway.fgw_nat_gateway.id
}

# NAT Gateway for Cluster VNet
resource "azurerm_nat_gateway" "clstr_nat_gateway" {
  name                = "CLSTR-NAT-GW"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  sku_name = "Standard"

  tags = {
    fastpathenabled = "true"
  }
}

resource "azurerm_public_ip" "clstr_nat_ip" {
  name                = "CLSTR-NAT-IP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_nat_gateway_public_ip_association" "clstr_nat_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.clstr_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.clstr_nat_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "clstr_nat_assoc" {
  subnet_id      = local.clstr_subnet[0].id  
  nat_gateway_id = azurerm_nat_gateway.clstr_nat_gateway.id
}

# NAT Gateway for PC VNet
resource "azurerm_nat_gateway" "pc_nat_gateway" {
  name                = "PC-NAT-GW"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  sku_name = "Standard"

  tags = {
    fastpathenabled = "true"
  }
}

resource "azurerm_public_ip" "pc_nat_ip" {
  name                = "PC-NAT-IP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_nat_gateway_public_ip_association" "pc_nat_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.pc_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.pc_nat_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "pc_nat_assoc" {
  subnet_id      = local.pc_subnet[0].id  
  nat_gateway_id = azurerm_nat_gateway.pc_nat_gateway.id
}

resource "azurerm_subnet_nat_gateway_association" "fgwbgp_nat_assoc" {
  subnet_id      = local.bgp_subnet[0].id 
  nat_gateway_id = azurerm_nat_gateway.fgw_nat_gateway.id
}
