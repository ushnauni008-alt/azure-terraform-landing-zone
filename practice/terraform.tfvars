rgs = {
  rg1 = {
    name     = "rg-usha"
    location = "eastus"
  }
}
vnets = {
  vnet1 = {
    name                = "practice_vnet"
    location            = module.resource_group["rg1"].location
    resource_group_name = module.resource_group["rg1"].name
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "practice_subnet"
    resource_group_name  = module.resource_group["rg1"].name
    virtual_network_name = module.virtual_network["vnet1"].name
    address_prefixes     = ["10.0.0.0/24"]
  }

}