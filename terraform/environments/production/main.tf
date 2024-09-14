provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source           = "../../modules/vpc"
  region           = "us-west-2"
  vpc_cidr         = "10.0.0.0/16"
  public_subnet_count = 2
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_count = 2
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "eks" {
  source             = "../../modules/eks"
  region             = "us-west-2"
  cluster_name       = "production-cluster"
  subnet_ids         = module.vpc.public_subnet_ids
  node_desired_size  = 2
  node_max_size      = 5
  node_min_size      = 1
}

module "s3" {
  source        = "../../modules/s3"
  region        = "us-west-2"
  bucket_name   = "production-bucket"
}

