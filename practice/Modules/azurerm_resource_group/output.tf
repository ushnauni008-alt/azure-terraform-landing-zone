output "resource_group_names" {
  value = {
     for key, rg in azurerm_resource_group.rg:
     key=>resource_group.name
  }

}
output "resource_group_locations"{
  value = {
    for key, rg in azurerm_resource_group.rg:
    key=>resopurce_group.location
  }
}