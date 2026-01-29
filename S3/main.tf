resource "aws_s3_bucket" "my_s3" {
  bucket = var.s3-name
  tags = {
    Name = "jenkins-logs"
  }
  force_destroy = true

}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_s3.id

  versioning_configuration {
    status = "Enabled"
  }
}

