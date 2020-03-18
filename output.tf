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

output "network_security_groups" {
  description = "Map output of the Network Security Groups"
  value       = { for k, b in azurerm_network_security_group.nsgs : k => b }
}


output "route_tables" {
  description = "Map output of the Route Tables"
  value       = { for k, b in azurerm_route_table.rts : k => b }
}

output "public_ips" {
  description = "Map output of the Public Ips"
  value       = { for k, b in azurerm_public_ip.pips : k => b }
}

output "private_endpoints" {
  description = "Map output of the private endpoints"
  value       = { for k, b in azurerm_private_endpoint.pend : k => b }
}
