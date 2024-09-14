provider "aws" {
  region = "us-west-2"
}

resource "aws_eks_cluster" "main" {
  name     = "my-cluster"
  role_arn  = aws_iam_role.eks.arn
  version   = "1.21"

  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }
}

# Node group configuration
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids       = aws_subnet.public[*].id
  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }
}

# IAM roles and other configurations
