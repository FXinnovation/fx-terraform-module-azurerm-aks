provider "azurerm" {
  version         = "~> 1.28.0"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

provider "azuread" {
  version         = "~> 0.4.0"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

provider "random" {
  version = "~> 2.0"
}
