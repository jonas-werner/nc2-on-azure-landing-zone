# Azure NC2 landing zone

This repository contains Terraform/OpenTofu configurations for deploying an Azure landing zone suitable for deploying a Nutanix Cloud Clusters (NC2) cluster. It includes S2S VPN connectivity with BGP routing to an on-prem environment with the creation of all vNets, peerings, VPN gateways, NAT gateways, and Azure Route Server resources required. 

Diagram of what is deployed (minus the actual NC2 cluster): 
![Diagram of Azure resources created](https://jonamiki.com/wp-content/uploads/2024/12/Screenshot-2024-12-19-at-15.10.32.png)

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://developer.hashicorp.com/terraform/downloads) or [OpenTofu](https://opentofu.org/docs/intro/install/)
- Azure subscription with appropriate permissions

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/jonas-werner/nc2-on-azure-landing-zone.git
   cd azure-nc2-resources
   ```

2. Log in to Azure:
   ```bash
   az login
   ```

3. Configure your deployment by editing `terraform.tfvars`:
   - Set your subscription ID
   - Configure resource group name
   - Update network CIDR ranges if needed
   - Set your VPN shared key
   - Configure other variables as needed

4. Initialize Terraform/OpenTofu:
   ```bash
   terraform init
   # or
   tofu init
   ```

5. Create and review the execution plan:
   ```bash
   terraform plan -out nc2-on-azure.plan
   # or
   tofu plan -out nc2-on-azure.plan
   ```

6. Apply the configuration:
   ```bash
   terraform apply nc2-on-azure.plan
   # or
   tofu apply nc2-on-azure.plan
   ```

## Handling Timeouts

Azure resource creation can sometimes time out, especially during VNet peering operations. If you encounter timeouts:

1. Wait a few minutes
2. Run plan again to check the current state:
   ```bash
   terraform plan -out nc2-on-azure.plan
   # or
   tofu plan -out nc2-on-azure.plan
   ```
3. Apply the plan:
   ```bash
   terraform apply nc2-on-azure.plan
   # or
   tofu apply nc2-on-azure.plan
   ```

The deployment will continue from where it left off, and resources that were already created will be skipped.

## Resource Cleanup

To remove all created resources:

```bash
terraform destroy
# or
tofu destroy
```

## Architecture

The deployment creates the following resources:

- Hub Virtual Network with subnets for:
  - Default subnet
  - Azure Route Server
  - NAT Gateway
  - VPN Gateway
- Flow Gateway (FGW) Virtual Network
- Cluster (CLSTR) Virtual Network
- PC Virtual Network
- VNet peering between all networks (mesh - required for NC2)
- VPN Gateway with BGP support
- NAT Gateway for outbound connectivity
- Azure Route Server for BGP routing

## Note

After deployment, navigate to: Route Server -> Settings -> Configuration and update the "Branch-to-branch" setting to "Enabled". This is required for the Rotue Server to share NC2 overlay network routes over BGP. Also change the "Routing Preference" to "VPN" to ensure the RS shares the routes with the VPN GW instance. 

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Jonas Werner
- Web: https://jonamiki.com 
