module "apim_default" {
  source                  = "./modules/apim"
  name                    = var.apim_default_name
  sku_name                = var.apim_default_sku_name
  resource_group_location = module.resource_group_hub.location
  resource_group_name     = module.resource_group_hub.name
  publisher_name          = var.apim_default_publisher_name
  publisher_email         = var.apim_default_publisher_email
}
