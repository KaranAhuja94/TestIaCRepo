resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "bucket_256"
  force_destroy = true
}

resource "aws_cloudtrail" "cid256_pass" {
  name = "cid_256_pass"
  s3_bucket_name = aws_s3_bucket.cloudtrail_bucket.id
  is_organization_trail = true
}