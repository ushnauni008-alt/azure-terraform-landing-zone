data "azurerm_subnet" "snet" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  depends_on           = [module.subnet]
}

data "azurerm_network_security_group" "nsg" {
  for_each            = var.network_security_groups
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  depends_on          = [module.network_security_group]
}

data "azurerm_application_security_group" "asg" {
  for_each            = var.application_security_groups
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  depends_on          = [module.application_security_group]
}

data "azurerm_public_ip" "pip" {
  for_each            = var.public_ips
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  depends_on          = [module.public_ip]
}