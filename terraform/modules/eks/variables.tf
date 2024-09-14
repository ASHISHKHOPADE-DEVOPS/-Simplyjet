variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_desired_size" {
  description = "Desired size of the node group"
  type        = number
}

variable "node_max_size" {
  description = "Maximum size of the node group"
  type        = number
}

variable "node_min_size" {
  description = "Minimum size of the node group"
  type        = number
}
