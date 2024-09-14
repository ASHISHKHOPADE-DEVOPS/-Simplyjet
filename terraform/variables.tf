variable "aws_region" {
  type = string
  default = "us-west-2"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "cluster_name" {
  type = string
  default = "production-cluster"
}

variable "bucket_name" {
  type = string
  default = "production-bucket"
}

variable "volume_size" {
  type = number
  default = 100
}

variable "availability_zone" {
  type = string
  default = "us-west-2a"
}
