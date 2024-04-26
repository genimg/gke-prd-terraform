resource "azurerm_kubernetes_cluster" "expertia" {
  name                = "d-vuelo-aks-eus2-z3f1"
  location            = azurerm_resource_group.p_spoke_aks_mv_rg.location
  resource_group_name = azurerm_resource_group.p_spoke_aks_mv_rg.name
  dns_prefix          = "mvexpertia"
  local_account_disabled = true #deshabilitar local accounts
  private_cluster_enabled = true
  public_network_access_enabled = false

  default_node_pool {
    name       = "dvueloeus2"
    #node_count = 3
    vm_size    = "Standard_B4ms"
    enable_auto_scaling = true
    min_count = 1
    max_count = 3
    type = "VirtualMachineScaleSets"
    zones = ["1","3"]
    vnet_subnet_id = azurerm_subnet.p_aks_mv_subnet.id
    max_pods = 30
    os_disk_size_gb = 100
  }

  private_cluster_public_fqdn_enabled = true
  role_based_access_control_enabled   = true

  azure_active_directory_role_based_access_control {
        managed            = true
        azure_rbac_enabled = true
  }
  
 

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    load_balancer_sku = "standard"


  }

  identity {
    type = "SystemAssigned"
  }

  

    ingress_application_gateway {
      #gateway_name = "expertia-appgw"
      gateway_name = "d-vuelo-agw-eus2-a6b8"
      #subnet_cidr  = "10.1.5.0/27"
      subnet_id = azurerm_subnet.application_gateway_subnet.id
    }

    azure_policy_enabled = true

    //service_mesh_profile {
    //  mode = "Istio"
    //  internal_ingress_gateway_enabled = true
    //  external_ingress_gateway_enabled = false
    //}

    

  tags = {
    Environment = "Development"
  }
}

###role de la identidad asigna al agic


data "azurerm_user_assigned_identity" "expertia" {
  name                = "ingressapplicationgateway-d-vuelo-aks-eus2-z3f1"
  resource_group_name = "MC_d-vuelo-spoke-rg-eus2-mw4o_d-vuelo-aks-eus2-z3f1_eastus2"

   depends_on = [
    azurerm_kubernetes_cluster.expertia
  ]
}

/* output "uai_client_id" {
  value = data.azurerm_user_assigned_identity.example.client_id
}

output "uai_principal_id" {
  value = data.azurerm_user_assigned_identity.example.principal_id
}

output "uai_tenant_id" {
  value = data.azurerm_user_assigned_identity.example.tenant_id
} */

resource "azurerm_role_assignment" "expertia" {
  scope                = azurerm_resource_group.p_spoke_aks_mv_rg.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azurerm_user_assigned_identity.expertia.principal_id
}

######flux config


resource "azurerm_kubernetes_cluster_extension" "expertia" {
  name           = "expertia"
  cluster_id     = azurerm_kubernetes_cluster.expertia.id
  extension_type = "microsoft.flux"
}

resource "azurerm_kubernetes_flux_configuration" "expertia" {
  name       = "expertia-fc"
  cluster_id = azurerm_kubernetes_cluster.expertia.id
  namespace  = "flux"

  git_repository {
    url             = "https://github.com/gabrielggg/arc-k8s-demo"
    reference_type  = "branch"
    reference_value = "main"
  }

  kustomizations {
    name = "kustomization-1"
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.expertia
  ]
}
