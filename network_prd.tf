resource "google_compute_subnetwork" "sap_prd_subnet" {
  name          = "p-irmabo-integraciones-sap-subred1"
  network       = "projects/${var.host_project_id}/global/networks/vpc-irmabo-integraciones-sap"
  region        = var.host_region
  ip_cidr_range = "10.253.115.0/24"

  secondary_ip_range {
    range_name    = "sap-prd-pods"
    ip_cidr_range = "10.253.116.0/22"
  }

  secondary_ip_range {
    range_name    = "sap-prd-services"
    ip_cidr_range = "10.253.132.0/24"
  }
}
