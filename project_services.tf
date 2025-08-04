locals {
  gcp_services = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "gkehub.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]
}

resource "google_project_service" "enable" {
  provider = google.spoke
  for_each = toset(local.gcp_services)

  project = var.spoke_project_id
  service = each.key
}
