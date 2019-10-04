resource "azurerm_resource_group" "rg_dmz" {
  name                              = "${var.rg_name}"
  location                          = "${var.rg_location}"
}

