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
# Description: Azure provider configuration and resource group setup
#              This file configures the Azure provider and creates the main resource group
#

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
