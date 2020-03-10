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
  value       = { for k, x in azurerm_virtual_network.vnets : k => { "id" = x.id, "name" = x.name, "location" = x.location, resource_group_name = x.resource_group_name } }
}
output "subnets" {
  description = "Map output of the managed subnets"
  value       = { for k, b in azurerm_subnet.subnets : k => { "address_prefix" = b.address_prefix, "id" = b.id, "name" = b.name } }
}
