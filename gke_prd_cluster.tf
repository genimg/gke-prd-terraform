resource "google_container_cluster" "sap_prd" {
  provider = google.spoke

  name     = "integration-sap-prd-cluster"
  location = "southamerica-west1"

  release_channel { channel = "regular" }
  networking_mode = "VPC_NATIVE"

  network    = "projects/${var.host_project_id}/global/networks/vpc-irmabo-integraciones-sap"
  subnetwork = "projects/${var.host_project_id}/regions/southamerica-west1/subnetworks/p-irmabo-integraciones-sap-subred1"

  ip_allocation_policy {
    cluster_secondary_range_name  = "sap-prd-pods"
    services_secondary_range_name = "sap-prd-services"
  }

  private_cluster_config {
    enable_private_nodes   = true
    master_ipv4_cidr_block = "10.253.11.0/28"
    enable_private_endpoint = true
    master_global_access_config { enabled = false }
  }

  addons_config {
    gke_gateway_config { channel = "CHANNEL_STANDARD" }
  }

  remove_default_node_pool = true
  lifecycle {
    ignore_changes = [maintenance_policy]
  }
}
