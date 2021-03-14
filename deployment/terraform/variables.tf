
variable "civo_token" {
  description = "Civo API token"
}

variable "cluster_name" {
  description = "Civo Kubernetes cluster name"
}

variable "applications" {
  description = "Defaut installed application on cluster"
  default     = "Traefik v2, Loki, Cert Manager, Prometheus Operator"
}

variable "node_count" {
  description = "Number of cluster nodes"
  default     = 3
}

variable "instance_size" {
  description = "Instance flavor size"
  default     = ["small"]
}