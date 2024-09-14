provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "eks" {
  source = "../../modules/eks"
  cluster_name = var.cluster_name
}

module "storage" {
  source = "../../modules/storage"
  bucket_name = var.bucket_name
}

module "security" {
  source = "../../modules/security"
}
