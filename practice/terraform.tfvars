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