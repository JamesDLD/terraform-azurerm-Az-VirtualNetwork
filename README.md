Test
-----
[![Build Status](https://dev.azure.com/jamesdld23/vpc_lab/_apis/build/status/JamesDLD.terraform-azurerm-Az-VirtualNetwork?branchName=master)](https://dev.azure.com/jamesdld23/vpc_lab/_build/latest?definitionId=13&branchName=master)

Requirement
-----
Terraform v0.12.6 and above. 
AzureRm provider 1.36.0 and above to support the Terraform esource azurerm_bastion_host.

Examples
-----

| Name | Description |
|------|-------------|
| complete | Create the following objects : vnet, subnet, azure bastion, route table, network security group, public ip and does the virtual network peering. |