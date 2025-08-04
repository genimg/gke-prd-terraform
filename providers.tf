// providers.tf
provider "google" {
  project = var.host_project_id
  region  = "southamerica-west1"
}

provider "google" {
  alias   = "spoke"
  project = var.spoke_project_id
  region  = "southamerica-west1"
}
