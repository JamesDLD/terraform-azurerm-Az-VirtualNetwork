# -
# - Network - List outputs
# -

output "vnet_ids" {
  value = [for x in azurerm_virtual_network.vnets : x.id]
}

output "vnet_names" {
  value = [for x in azurerm_virtual_network.vnets : x.name]
}

output "vnet_locations" {
  value = [for x in azurerm_virtual_network.vnets : x.location]
}

output "vnet_rgnames" {
  value = [for x in azurerm_virtual_network.vnets : x.resource_group_name]
}

output "subnet_ids" {
  value = [for x in azurerm_subnet.subnets : x.id]

}
output "network_security_group_ids" {
  value = [for x in azurerm_network_security_group.nsgs : x.id]
}
output "route_table_ids" {
  value = [for x in azurerm_route_table.rts : x.id]
}

output "public_ip_ids" {
  value = [for x in azurerm_public_ip.pips : x.id]
}

# -
# - Network - Map outputs
# -

output "vnets" {
  description = "Map output of the managed virtual networks"
  value       = { for k, b in azurerm_virtual_network.vnets : k => b }
}

output "subnets" {
  description = "Map output of the managed subnets"
  value       = { for k, b in azurerm_subnet.subnets : k => b }
}

output "private_endpoints" {
  description = "Map output of the private endpoints"
  value       = { for k, b in azurerm_private_endpoint.pend : k => b }
}

#data.azurerm_private_endpoint_connection.example.private_service_connection.0.status
