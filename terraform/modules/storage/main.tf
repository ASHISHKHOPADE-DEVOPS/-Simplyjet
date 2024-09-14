resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name
  acl = "private"
  tags = {
    Name = "AppBucket"
  }
}

resource "aws_ebs_volume" "app_volume" {
  availability_zone = var.availability_zone
  size = var.volume_size
  tags = {
    Name = "AppVolume"
  }
}
