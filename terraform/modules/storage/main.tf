provider "aws" {
  region = var.region
}

resource "aws_ebs_volume" "example" {
  availability_zone = var.availability_zone
  size              = var.size
  tags = {
    Name = "example-ebs-volume"
  }
}

output "ebs_volume_id" {
  value = aws_ebs_volume.example.id
}

