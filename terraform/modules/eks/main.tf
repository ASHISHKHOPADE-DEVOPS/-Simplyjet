module "eks" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  cluster_version = "1.21"
  subnets = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
  vpc_id = aws_vpc.main.id
  node_groups = {
    worker_group = {
      desired_capacity = 2
      max_capacity = 5
      min_capacity = 1
      instance_type = "t3.medium"
    }
  }
}
