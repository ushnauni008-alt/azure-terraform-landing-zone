module "resource_group" {
  source          = "./Modules/azurerm_resource_group"
  resource_groups = var.rgs
}

module "virtual_network" {
  source           = "./Modules/azurerm_virtual_network"
  virtual_networks = var.vnets
}

module "subnet" {
  source  = "./Modules/azurerm_subnet"
  subnets = var.subnets


}