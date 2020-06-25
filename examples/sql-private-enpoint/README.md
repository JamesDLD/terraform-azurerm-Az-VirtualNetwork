Test
-----
[![Build Status](https://dev.azure.com/jamesdld23/vpc_lab/_apis/build/status/JamesDLD.terraform-azurerm-Az-VirtualNetwork?branchName=master)](https://dev.azure.com/jamesdld23/vpc_lab/_build/latest?definitionId=13&branchName=master)


Content
-----
Create the following objects : vnet, subnet, Azure SQL server with a dedicated private enpoint.

Requirement
-----
Terraform v0.12.23 and above. 
AzureRm provider version 2.1 and above.

Usage
-----
```hcl
#Set the terraform backend
terraform {
  backend "local" {} #Using a local backend just for the demo, the reco is to use a remote backend, see : https://jamesdld.github.io/terraform/Best-Practice/BestPractice-1/
}

#Set the Provider
provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  version         = "~> 2.0"
  features {}
}

#Set authentication variables
variable "tenant_id" {
  description = "Azure tenant Id."
}

variable "subscription_id" {
  description = "Azure subscription Id."
}

variable "client_id" {
  description = "Azure service principal application Id."
}

variable "client_secret" {
  description = "Azure service principal application Secret."
}

#Set resource variables

# -
# - Network object
# -
variable "virtual_networks" {
  default = {

    hub-noprd1 = {
      id            = "1"
      prefix        = "noprd"
      address_space = ["10.0.0.0/24"]
    }

  }
}

variable "subnets" {
  default = {

    endpoint-snet1 = {
      vnet_key                                       = "hub-noprd1"     #(Mandatory) 
      name                                           = "endpoint-snet1" #(Mandatory) 
      address_prefixes                                 = ["10.0.0.32/27"]   #(Mandatory) 
      enforce_private_link_endpoint_network_policies = true             #(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Default valule is false. Conflicts with enforce_private_link_service_network_policies.
    }

  }
}


variable "private_endpoints" {
  description = "Manages a Private Endpoints. See https://www.terraform.io/docs/providers/azurerm/r/private_endpoint.html"
  default = {

    pv1 = {
      id              = "1"                                                #(Mandatory)
      prefix          = "dataplatform"                                     #(Mandatory)
      snet_key        = "endpoint-snet1"                                   #(Mandatory) Subnet key
      request_message = "Approve the Pivate Enpoint for your SQL service." #(Optional) A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource. The request message can be a maximum of 140 characters in length. Only valid if is_manual_connection is set to true.
      private_service_connection = [
        {
          name                 = "sql1" #(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created.
          is_manual_connection = true   #(Required) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created. NOTE: If you are trying to connect the Private Endpoint to a remote resource without having the correct RBAC permissions on the remote resource set this value to true.
          #private_connection_resource_id = "/subscriptions/xxxxxxxxxxx/resourceGroups/dld-corp-mvp-dataplatform/providers/Microsoft.Sql/servers/dld-corp-mvp-sqldb-server" #(Use this variable or private_connection_resource_key) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. Changing this forces a new resource to be created.
          private_connection_resource_key = "sql1"        #(Use this variable or private_connection_resource_key) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. Changing this forces a new resource to be created.
          subresource_names               = ["sqlServer"] #(Optional) A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id. Changing this forces a new resource to be created.
        },
      ]
    }

  }
}

# -
# - Azure SQL object
# -
variable "sql_servers" {
  default = {
    sql1 = {
      name                         = "private-endpoint-sqldb-server1"
      resource_group_name          = "infr-jdld-noprd-rg1"
      location                     = "West Europe"
      version                      = "12.0"
      administrator_login          = "mradministrator"
      administrator_login_password = "thisIsDog11" #Remove this line after the creation to delete this password from the tfstate. Read more about sensitive data in state : https://www.terraform.io/docs/state/sensitive-data.html.
    }
  }
}

# -
# - Module & Resource
# -

resource "azurerm_sql_server" "sqls" {
  for_each                     = var.sql_servers
  name                         = each.value["name"]
  resource_group_name          = each.value["resource_group_name"]
  location                     = each.value["location"]
  version                      = lookup(each.value, "version", null)
  administrator_login          = each.value["administrator_login"]
  administrator_login_password = lookup(each.value, "administrator_login_password", "") #Warning : All arguments including the administrator login and password will be stored in the raw state as plain-text. Read more about sensitive data in state : https://www.terraform.io/docs/state/sensitive-data.html.
}

module "Az-VirtualNetwork-Demo" {
  source                       = "JamesDLD/Az-VirtualNetwork/azurerm"
  version                      = "0.2.0"
  net_prefix                   = "hub-demo"
  network_resource_group_name  = "infr-jdld-noprd-rg1"
  virtual_networks             = var.virtual_networks
  subnets                      = var.subnets
  private_endpoints            = var.private_endpoints
  private_connection_resources = { for x, y in azurerm_sql_server.sqls : x => y } #Map of resources containg the id of the resource to link to the private endpoint
}

# -
# - Output
# -

output "private_endpoints" {
  value = module.Az-VirtualNetwork-Demo.private_endpoints
}


```