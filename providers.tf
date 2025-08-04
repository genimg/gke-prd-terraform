terraform {
  required_providers {
    
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  backend "gcs" {
    bucket  = "<YOUR_STATE_BUCKET>"
    prefix  = "terraform/state"
  }

  }
}

provider "random" {}



# Google provider configuration
provider "google" {
  project = var.gcp_project_id
  region  = var.gke_main_location
}