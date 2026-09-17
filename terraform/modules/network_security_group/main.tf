resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsgs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}
resource "azurerm_network_security_rule" "nsg_rule" {
  for_each                    = var.nsg_rules
  name                        = each.value.name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.nsg_key].name
  resource_group_name         = azurerm_network_security_group.nsg[each.value.nsg_key].resource_group_name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix = (
    length(each.value.source_application_security_group_ids) == 0
    ? each.value.source_address_prefix
    : null
  )
  destination_address_prefix = (
    length(each.value.destination_application_security_group_ids) == 0
    ? each.value.destination_address_prefix
    : null
  )
  source_application_security_group_ids = (
    length(each.value.source_application_security_group_ids) > 0
    ? each.value.source_application_security_group_ids
    : null
  )
  destination_application_security_group_ids = (
    length(each.value.destination_application_security_group_ids) > 0
    ? each.value.destination_application_security_group_ids
    : null
  )
}