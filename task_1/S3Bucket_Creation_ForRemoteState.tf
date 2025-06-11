
resource "aws_s3_bucket" "remote_state" {
  bucket = var.bucket_name


  tags = {
    Name        = "Remote State Bucket for DevOps Course"
    Owner       = "Aksana Babich"
  }
}