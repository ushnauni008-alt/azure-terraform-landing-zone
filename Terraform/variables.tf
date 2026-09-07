variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
}
variable "virtual_networks" {
  type = map(object({
    name               = string
    resource_group_key = string
    location           = string
    address_space      = list(string)
  }))
}
variable "subnets" {
  type = map(object({
    name                = string
    virtual_network_key = string
    address_prefixes    = list(string)
  }))
}