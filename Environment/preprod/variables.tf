variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
}
variable "virtual_networks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
}
variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}
variable "network_security_groups" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}
variable "network_security_rules" {
  type = map(object({
    name                       = string
    nsg_key                    = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    source_asg_key             = string
    destination_asg_key        = string
  }))
}
variable "application_security_groups" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}
variable "public_ips" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
  }))
}
variable "network_interfaces" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    subnet_key            = string
    private_ip_allocation = string
    public_ip_key         = string
    nsg_key               = string
    asg_key               = string
  }))
}
