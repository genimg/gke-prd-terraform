locals {
  attach_acr_role_definition_name             = "AcrPull"
  attach_acr_skip_service_principal_aad_check = true
  
  user_pool_name                              = "userpool"
  user_pool_mode                              = "User"
  user_pool_os_type                           = "Linux"
  user_pool_priority                          = "Spot"
  user_pool_eviction_policy                   = "Delete"
  user_pool_spot_max_price                    = 0.5  
  user_pool_node_labels_nodepool_type         = "user-nodes"
  user_pool_node_taints                       = "sku=spot:NoSchedule" 
}