# Azure Providers source and version being used changetest13
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=2.52.0"
    }
  }
}

# Configure rhe Microsoft Azure Provider
provider "azurerm" {
    features {}      
  }

  resource "azurerm_resource_group" "myrg" {
    name = "ggeorgiou-rg"
    location = "UK South"
    
  }

  # Create a virtual network within the resorce group
  resource "azurerm_virtual_network" "myvnet" {
    name = "ggeorgiou-vnet"
    resource_group_name = azurerm_resource_group.myrg.name
    location = azurerm_resource_group.myrg.location
    address_space = [ "10.0.0.0/16" ]  
  }

  # Create a subnet within the vnet
  resource "azurerm_subnet" "mysubnet" {
    name = "VLAN-001"
    resource_group_name = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes = [ "10.0.1.0/24" ]
  }


  # Create a subnet within the vnet2
  resource "azurerm_subnet" "mysubnet2" {
    name = "VLAN-002"
    resource_group_name = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
   address_prefixes = [ "10.0.2.0/24" ]
  }

   # Create a subnet within the vnet3
  resource "azurerm_subnet" "mysubnet3" {
    name = "VLAN-003"
    resource_group_name = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
   address_prefixes = [ "10.0.3.0/24" ]
  }
  


resource "azurerm_public_ip" "myrg" {
  name                = "nat-gateway-publicIP"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}


resource "azurerm_public_ip_prefix" "myrg" {
  name                = "nat-gateway-publicIPPrefix"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  prefix_length       = 30
  zones               = ["1"]
}


resource "azurerm_nat_gateway" "myrg" {
  name                = "example-natgateway"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]


}

