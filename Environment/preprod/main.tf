module "resource_group" {
  source = "../../modules/resource_group"
  rgs    = var.resource_groups
}
module "virtual_network" {
  source     = "../../modules/virtual_network"
  depends_on = [module.resource_group]
  vnets      = var.virtual_networks
}

module "subnet" {
  source     = "../../modules/subnet"
  depends_on = [module.virtual_network]
  snets      = var.subnets
}

module "network_security_group" {
  source     = "../../modules/network_security_group"
  depends_on = [module.resource_group, module.application_security_group]
  nsgs       = var.network_security_groups

  nsg_rules = {
    for key, rule in var.network_security_rules :
    key => {
      name                       = rule.name
      nsg_key                    = rule.nsg_key
      priority                   = rule.priority
      direction                  = rule.direction
      access                     = rule.access
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      destination_port_range     = rule.destination_port_range
      source_address_prefix      = rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix

      source_application_security_group_ids = (
        rule.source_asg_key != ""
        ? [data.azurerm_application_security_group.asg[rule.source_asg_key].id]
        : []
      )

      destination_application_security_group_ids = (
        rule.destination_asg_key != ""
        ? [data.azurerm_application_security_group.asg[rule.destination_asg_key].id]
        : []
      )
    }
  }
}

module "application_security_group" {
  source     = "../../modules/application_security_group"
  depends_on = [module.resource_group]
  asgs       = var.application_security_groups
}

module "public_ip" {
  source     = "../../modules/public_ip"
  depends_on = [module.resource_group]
  pips       = var.public_ips
}

module "network_interface" {
  source     = "../../modules/network_interface"
  depends_on = [module.subnet, module.network_security_group, module.application_security_group, module.public_ip]
  nics = {
    for key, nic in var.network_interfaces :
    key => {
      name                          = nic.name
      location                      = nic.location
      resource_group_name           = nic.resource_group_name
      subnet_id                     = data.azurerm_subnet.snet[nic.subnet_key].id
      private_ip_address_allocation = nic.private_ip_allocation
      public_ip_address_id = (
        nic.public_ip_key != ""
        ? data.azurerm_public_ip.pip[nic.public_ip_key].id
        : null
      )
      network_security_group_id = (
        nic.nsg_key != ""
        ? data.azurerm_network_security_group.nsg[nic.nsg_key].id
        : null
      )
      application_security_group_id = (
        nic.asg_key != ""
        ? data.azurerm_application_security_group.asg[nic.asg_key].id
        : null
      )
    }

  }
}