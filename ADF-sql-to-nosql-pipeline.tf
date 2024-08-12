#Define Provider
provider "azurerm" {
  features {}
}

#Provision Resource Group
resource "azurerm_resource_group" "rg" {
  name = "nameOfRG"
  location = "West US"
}

#Provision Data factory
resource "azurerm_data_factory" "ADF" {
  name = "nameOfDataFactory"
  location = azurerm_resource_group.rg.location
}

#Provision ADF pipeline
resource "azurerm_data_factory_pipeline" "ADFpipeline" {
  name = "nameOfADFpipeline"
  data_factory_name = azurerm_data_factory.ADF.name
  resource_group_name = azurerm_resource_group.rg.name
  description = "SQL to NoSQL pipeline"

#Provision Activities
activities = [
  {
    name = "example-copy-activity"
    type = "Copy"

    inputs = [
      {
        name = "input-dataset"
      }
    ]

    outputs = [
      {
        name = "output-dataset"
      }
    ]

    copy = {
      source = {
        type = "BlobSource"
      }
      sink = {
        type = "SqlSink"
      }
    }
  ]
}


