
/*
resource "aws_s3_bucket" "remote_state" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name  = "Remote State Bucket for DevOps Course"
    Owner = "Aksana Babich"
  }
}
 */