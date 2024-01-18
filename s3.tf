resource "aws_s3_bucket" "backend" {
  bucket = "jddbucket" #must be globally unique
}
resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws.aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Disabled"
  }
}