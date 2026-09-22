variable "nsgs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}
variable "nsg_rules" {
  type = map(object({
    name                                       = string
    nsg_key                                   = string
    priority                                   = number
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = string
    destination_port_range                     = string
    source_address_prefix                      = string
    destination_address_prefix                 = string
    source_application_security_group_ids      = list(string)
    destination_application_security_group_ids = list(string)
  }))
}