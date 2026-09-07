output "virtual_network" {
  value = {
    for key, vnet in azurerm_virtual_network.vnets :
    key => {
      name                = vnet.name
      location            = vnet.location
      resource_group_name = vnet.resource_group_name
      address_space       = vnet.address_space
      id                  = vnet.id
    }
  }
}