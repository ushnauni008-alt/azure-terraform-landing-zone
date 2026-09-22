resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                          = "${each.value.name}-ipconfig"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    public_ip_address_id = (
      each.value.public_ip_address_id != ""
      ? each.value.public_ip_address_id
      : null
    )
  }
}
resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  for_each                  = var.nics
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = each.value.network_security_group_id

}
resource "azurerm_network_interface_application_security_group_association" "nic_asg_association" {
  for_each                      = var.nics
  network_interface_id          = azurerm_network_interface.nic[each.key].id
  application_security_group_id = each.value.application_security_group_id

}