resource "random_shuffle" "az" {
  input = [
    "eastasia", # East Asia
    "japaneast", # JA West
    "japanwest", # JA West
    "koreacentral", # KR Central
    "southeastasia", # Southeast Asia
    "southindia", # IN South
    "westindia", # IN West
    "centralindia" # (Asia Pacific) Central India
  ]
  result_count = 4
}

resource "azurerm_resource_group" "stoprussia" {
    name     = var.resource_group_name
    location = var.region
}

resource "azurerm_container_group" "stoprussia" {

    for_each = {
 
    "vm1" = random_shuffle.az.result[0]
    "vm2" = random_shuffle.az.result[0]
    "vm3" = random_shuffle.az.result[0]
    "vm4" = random_shuffle.az.result[0]
    
    }
    name = each.key
    location            = each.value
    resource_group_name = azurerm_resource_group.stoprussia.name

    ip_address_type     = "None"
    os_type             = "Linux"
    restart_policy      = "Always"

    container {
        name   = "stoprussia-0"
        image  = "abagayev/stop-russia:latest"
        cpu    = var.cpu_spec
        memory = var.mem_spec
    }

}