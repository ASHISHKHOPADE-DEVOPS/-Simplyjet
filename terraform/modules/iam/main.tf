provider "aws" {
  region = var.region
}

resource "aws_iam_role" "example_role" {
  name               = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "example_policy_attachment" {
  name       = "example-policy-attachment"
  roles      = [aws_iam_role.example_role.name]
  policy_arn  = var.policy_arn
}

output "role_arn" {
  value = aws_iam
