module "resource_group" {
  source = "./modules/resource_group"
  rgs    = var.resource_groups
}

module "virtual_network" {
  source = "./modules/virtual_network"
  vnets = {
    for key, vnet in var.virtual_networks :
    key => {
      name                = vnet.name
      location            = vnet.location
      resource_group_name = module.resource_group.resource_group[vnet.resource_group_key].name
      address_space       = vnet.address_space
    }

  }
}

module "subnet" {
  source = "./modules/subnet"
  subnets = {
    for key, subnet in var.subnets :
    key => {
      name                 = subnet.name
      virtual_network_name = module.virtual_network.virtual_network[subnet.virtual_network_key].name
        resource_group_name  = module.virtual_network.virtual_network[subnet.virtual_network_key].resource_group_name
        address_prefixes     = subnet.address_prefixes
    }
  }
}
