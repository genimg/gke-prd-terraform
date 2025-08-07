data "google_compute_subnetwork" "sap_prd_subnet" {
  name          = "p-irmabo-integraciones-sap-subred1"
  #network       = "projects/${var.host_project_id}/global/networks/vpc-irmabo-integraciones-sap"
  project       = var.host_project_id
  region        = "southamerica-west1"
  #ip_cidr_range = "10.253.115.0/24"

  # secondary_ip_range {
  #   range_name    = "sap-prd-pods"
  #   ip_cidr_range = "10.253.116.0/22"
  # }

  # secondary_ip_range {
  #   range_name    = "sap-prd-services"
  #   ip_cidr_range = "10.253.132.0/24"
  # }
}

data "google_compute_global_address" "cloudsql_range" {
  name    = "cloudsql-prd-range"
  project = var.host_project_id   # d-inrtcom-redes-ab34
}

# resource "google_service_networking_connection" "cloudsql_connection" {
#   network = "projects/${var.host_project_id}/global/networks/vpc-irmabo-integraciones-sap"
#   service = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_global_address.cloudsql_range.name]
# }
