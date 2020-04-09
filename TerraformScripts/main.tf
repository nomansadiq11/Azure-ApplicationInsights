

resource "azurerm_resource_group" "rg-ApplicationInsights" {
  name     = "${var.resouce_group_name}"
  location = "${var.location}"

  tags = {
    environment = "${var.tag}"
  }
}





resource "azurerm_storage_account" "sa-applicationinsights" {
  name                     = "sa${random_integer.ri.result}"
  resource_group_name      = "${azurerm_resource_group.rg-ApplicationInsights.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

   tags = {
    environment = "${var.tag}"
  }

}



resource "azurerm_app_service_plan" "asp-af-applicationinsights" {
  name                = "ASPFAF"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg-ApplicationInsights.name}"

  sku {
    tier = "Basic"
    size = "B1"
    capacity = 1
  }

   tags = {
    environment = "${var.tag}"
  }
}




resource "azurerm_function_app" "af-applicationinsights" {
  name                      = "af${random_string.fqdn.result}"
  location                  = "${var.location}"
  resource_group_name       = "${azurerm_resource_group.rg-ApplicationInsights.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.asp-af-applicationinsights.id}"
  storage_connection_string = "${azurerm_storage_account.sa-applicationinsights.primary_connection_string}"

   tags = {
    environment = "${var.tag}"
  }

    app_settings = {
            
        
    }

}