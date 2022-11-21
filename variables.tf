variable "cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
  default     = null
}

variable "cluster_capacity_providers" {
  description = "Names of capacity providers to associate with the cluster."
  type        = list(string)
  default     = ["FARGATE"]
}

variable "container_insights" {
  description = "Controls if ECS Cluster has container insights enabled."
  type        = bool
  default     = true
}

variable "default_tags" {
  description = "The list of the default tags."
  type        = map(string)
  default     = {}
}
