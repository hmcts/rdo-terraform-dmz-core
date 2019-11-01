locals {
  isddosstandard = var.ddosplan != "basic" ? [1] : [0]
}

resource "azurerm_network_ddos_protection_plan" "main" {
  count               = var.ddosplan != "basic" ? 1 : 0
  name                = "ddospplan-${var.vnet_name}"
  location            = "${azurerm_resource_group.rg_dmz.location}"
  resource_group_name = "${azurerm_resource_group.rg_dmz.name}"
}

resource "azurerm_virtual_network" "vnet_dmz" {
  name                              = "${var.vnet_name}"
  location                          = "${azurerm_resource_group.rg_dmz.location}"
  resource_group_name               = "${azurerm_resource_group.rg_dmz.name}"
  address_space                     = ["${var.vnet_cidr}"]

  dynmaic "ddos_protection_plan" {
    for_each = local.isddosstandard

    content {
      id     = azurerm_network_ddos_protection_plan.main.id
      enable = true
    }
  }
}
