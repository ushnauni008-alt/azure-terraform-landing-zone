variable "nics" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    subnet_id                     = string
    public_ip_address_id          = string
    application_security_group_id = string
    network_security_group_id     = string
    private_ip_address_allocation = string
  }))
}