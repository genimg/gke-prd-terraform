data "azurerm_container_registry" "acr" {
  name                = var.registry_name
  resource_group_name = var.registry_resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                    = var.cluster_name
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.dns_prefix
  local_account_disabled  = var.local_account_disabled
  private_cluster_enabled = var.private_cluster_enabled

  default_node_pool {
    name                = var.default_node_name
    vm_size             = var.default_node_vm_size
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.default_node_min_count
    max_count           = var.default_node_max_count
    type                = var.default_node_type
    zones               = var.default_node_zones
    vnet_subnet_id      = var.default_node_subnet_id
    max_pods            = var.default_node_max_pods
    os_disk_size_gb     = var.default_node_os_disk_size_gb

    upgrade_settings {
      max_surge = "10%"
    }
  }

  private_cluster_public_fqdn_enabled = true
  role_based_access_control_enabled   = true

  azure_active_directory_role_based_access_control {
        managed            = true
        azure_rbac_enabled = true
  }

  network_profile {
    network_plugin    = var.network_profile_plugin
    network_policy    = var.network_profile_policy
    load_balancer_sku = var.network_profile_load_balancer_sku
  }

  identity {
    type = var.identity_type
  }

  azure_policy_enabled = var.azure_policy_enabled

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user_pool" {
  name                  = local.user_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = var.default_node_vm_size
  mode                  = local.user_pool_mode

  os_type               = local.user_pool_os_type
  enable_auto_scaling   = var.enable_auto_scaling
  min_count             = var.default_node_min_count
  max_count             = var.default_node_max_count
  priority              = local.user_pool_priority
  eviction_policy       = local.user_pool_eviction_policy
  spot_max_price        = local.user_pool_spot_max_price
   
  node_labels = {
    "nodepool-type" = local.user_pool_node_labels_nodepool_type
  }

  node_taints = [ 
    local.user_pool_node_taints
  ]

  depends_on = [ 
    azurerm_kubernetes_cluster.aks_cluster 
  ]
}

resource "azurerm_role_assignment" "acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
  role_definition_name             = local.attach_acr_role_definition_name
  scope                            = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = local.attach_acr_skip_service_principal_aad_check
}