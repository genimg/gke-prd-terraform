resource "google_compute_shared_vpc_service_project" "spoke_link" {
  host_project    = var.host_project_id
  service_project = var.spoke_project_id
}

// validar si existe
resource "google_compute_shared_vpc_service_project" "hub_link" {
  host_project    = var.spoke_project_id
  service_project = var.host_project_id
}
