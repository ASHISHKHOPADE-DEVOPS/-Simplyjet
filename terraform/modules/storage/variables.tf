variable "region" {
  description = "AWS region"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the EBS volume"
  type        = string
}

variable "size" {
  description = "Size of the EBS volume in GiB"
  type        = number
}
