# locals {
#   gcp_services = [
#     "container.googleapis.com",
#     "compute.googleapis.com",
#     "gkehub.googleapis.com",
#     "cloudresourcemanager.googleapis.com"
#   ]
#   sql_services = [
#     "sqladmin.googleapis.com",
#     "servicenetworking.googleapis.com"
#   ]
# }

# resource "google_project_service" "enable" {
#   provider = google.spoke
#   for_each = toset(local.gcp_services)

#   project = var.spoke_project_id
#   service = each.key
#   disable_on_destroy = false
#   lifecycle { 
#     prevent_destroy = true 
#   }
# }

# resource "google_project_service" "enable_sql" {
#   provider = google.spoke
#   for_each = toset(local.sql_services)

#   project = var.spoke_project_id
#   service = each.key
#   disable_on_destroy = false
#   lifecycle { 
#     prevent_destroy = true 
#   }
# }
