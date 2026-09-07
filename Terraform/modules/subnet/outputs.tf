output "subnets" {
  value = {
    for key, subnet in azurerm_subnet.subnets :
    key => {
      name                 = subnet.name
      resource_group_name  = subnet.resource_group_name
      virtual_network_name = subnet.virtual_network_name
      address_prefixes     = subnet.address_prefixes
      id                   = subnet.id
    }
  }
}