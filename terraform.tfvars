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
# Description: Terraform variables for Azure NC2 resources deployment
#              This file contains all configurable variables for the deployment
#

subscription_id                 = "1122334455-6677-aabb-ccdd-eeffgghhiijj"
resource_group_name             = "<your-rg-name>"  # The new resource grp to keep things organized
location                        = "Japan East"      # Region to deploy into
local_network_gateway_address   = "11.22.33.44"     # The on-prem VPN GW public IP
address_space                   = ["10.0.0.0/16"]   # The on-prem CIDR range

# Network CIDR configurations
# Feel free to set whatever range fits your environment here, but don't set the subnet mask to be too small. 
# Please refer to the official NC2 on Azure documentation for current limitations. 
hub_vnet_cidr                   = "10.240.0.0/22"
hub_default_subnet_cidr         = "10.240.0.0/24"
hub_ars_subnet_cidr             = "10.240.1.0/24"
hub_nat_subnet_cidr             = "10.240.2.0/24"
gateway_subnet_cidr             = "10.240.3.0/24"
fgw_vnet_cidr                   = "10.240.4.0/22"
clstr_vnet_cidr                 = "10.240.8.0/22"
pc_vnet_cidr                    = "10.240.12.0/22"

# VPN and BGP configurations
vpn_gateway_sku                 = "VpnGw2"          # The VPN GW need to be ver. 2. I don't know why I made this configurable
bgp_asn                         = 65515             # Your BGP AS number
vpn_shared_key                  = "<your-vpn-shared-secret>" 

# DNS configuration
# Note: NC2 require these to be set to something other than the default Azure DNS
#       We use Google DNS in this case, which has proven to be working fine. 
dns_servers                     = ["8.8.8.8", "8.8.4.4"] 

# Public IP configurations
public_ip_allocation_method     = "Static"
public_ip_sku                   = "Standard" 