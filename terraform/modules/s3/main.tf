provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = "private"
  tags = {
    Name = "example-s3-bucket"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.example.bucket
}
