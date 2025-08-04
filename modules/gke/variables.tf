variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "location" {
  description = "GCP region or zone for the cluster"
  type        = string
}

variable "project_id" {
  description = "GCP project ID where the cluster will be created"
  type        = string
}

variable "network" {
  description = "Self-link of the VPC network for the cluster"
  type        = string
}

variable "subnetwork" {
  description = "Self-link of the subnetwork for the cluster nodes"
  type        = string
}

variable "node_pools" {
  description = "List of node pool objects with name, machine_type, min_count, max_count, disk_size_gb, and labels"
  type = list(object({
    name           = string
    machine_type   = string
    min_count      = number
    max_count      = number
    disk_size_gb   = number
    labels         = map(string)
    taints         = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
  default = []
}

variable "tags" {
  description = "Resource labels/tags to apply to the cluster"
  type        = map(string)
  default     = {}
}
