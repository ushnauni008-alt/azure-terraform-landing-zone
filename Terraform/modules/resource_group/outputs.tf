output "resource_group" {
  value = {
    for key, rg in azurerm_resource_group.rgs :
    key => {
      name     = rg.name
      location = rg.location
      id       = rg.id
    }
  }

}