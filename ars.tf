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
# Description: Azure Route Server configuration for Azure NC2 resources
#              This file sets up the Azure Route Server and related resources
#

resource "azurerm_public_ip" "ars_pip" {
  name                = "ars-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_route_server" "ars" {
  name                = "ars"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  subnet_id           = azurerm_subnet.ars.id
  public_ip_address_id = azurerm_public_ip.ars_pip.id
}