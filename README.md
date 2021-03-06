Test
-----
[![Build Status](https://dev.azure.com/jamesdld23/vpc_lab/_apis/build/status/JamesDLD.terraform-azurerm-Az-VirtualNetwork?branchName=master)](https://dev.azure.com/jamesdld23/vpc_lab/_build/latest?definitionId=13&branchName=master)

Requirement
-----
- Terraform v0.12.23 and above. 
- AzureRm provider version 2.1 and above.

Terraform resources used within the module
-----
| Resource | Description |
|------|-------------|
| [data azurerm_resource_group](https://www.terraform.io/docs/providers/azurerm/d/resource_group.html) | Get the Resource Group, re use it's tags for the sub resources. |
| [data azurerm_subscription](https://www.terraform.io/docs/providers/azurerm/d/subscription.html) | Get an ARM subscription used when doing a virtual network peering. |
| [azurerm_virtual_network_peering](https://www.terraform.io/docs/providers/azurerm/r/virtual_network_peering.html) | Manages a virtual network peering. |
| [azurerm_virtual_network](https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html) | Manages Virtual Networks without the subnet block. |
| [azurerm_subnet](https://www.terraform.io/docs/providers/azurerm/r/subnet.html) | Manages Subnets. |
| [azurerm_route_table](https://www.terraform.io/docs/providers/azurerm/r/route_table.html) | Manages a Route Tables with their routes. |
| [azurerm_subnet_route_table_association](https://www.terraform.io/docs/providers/azurerm/r/subnet_route_table_association.html) | Associates a Route Table with a Subnet within a Virtual Network. |
| [azurerm_network_security_group](https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html) | Manages a network security group that contains a list of network security rules. |
| [azurerm_subnet_network_security_group_association](https://www.terraform.io/docs/providers/azurerm/r/subnet_network_security_group_association.html) | Associates a Network Security Group with a Subnet within a Virtual Network. |
| [azurerm_bastion_host](https://www.terraform.io/docs/providers/azurerm/r/bastion_host.html) | Manages Bastion Host Instances. |
| [azurerm_public_ip](https://www.terraform.io/docs/providers/azurerm/r/public_ip.html) | Manages Public Ips and Bastion Host Instances Public Ips. |
| [private_endpoint](https://www.terraform.io/docs/providers/azurerm/r/private_endpoint.html) | Manages a Private Endpoints. |


Examples
-----

| Name | Description |
|------|-------------|
| complete | Create the following objects : vnet, subnet, azure bastion, route table, network security group, public ip and does the virtual network peering. |
| sql-private-endpoint | Create the following objects : vnet, subnet, Azure SQL server with a dedicated private enpoint. |