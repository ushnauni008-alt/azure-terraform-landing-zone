rgs = {
  rg1 = {
    name     = "rg-usha"
    location = "eastus"
  }
}
vnets = {
  vnet1 = {
    name                = "practice_vnet"
    location            = "eastus"
    resource_group_name = "rg-usha"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "practice_subnet"
    resource_group_name  = "rg-usha"
    virtual_network_name = "practice_vnet"
    address_prefixes     = ["10.0.0.0/24"]
  }

}