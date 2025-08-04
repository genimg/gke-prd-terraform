variable "instance_name" {
  description = "Name of the bastion VM"
  type        = string
}

variable "zone" {
  description = "GCP zone for the instance"
  type        = string
}

variable "machine_type" {
  description = "Compute machine type (e.g. e2-medium)"
  type        = string
}

variable "network" {
  description = "VPC network self-link"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork self-link"
  type        = string
}

variable "tags" {
  description = "Network tags for the instance"
  type        = list(string)
  default     = ["bastion"]
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 20
}
