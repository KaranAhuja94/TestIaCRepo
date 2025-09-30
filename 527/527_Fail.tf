resource "aws_s3_bucket" "cid527bucket" {
  bucket = "terraform-kinesis-cid527-bucket"
}

data "aws_iam_policy_document" "cid527policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cid527kinesisrole" {
  name               = "terraform-kinesis-cid527-role"
  assume_role_policy = data.aws_iam_policy_document.cid527policy.json
}

resource "aws_kms_key" "cid527kinesiskey" {
  description = "Created for CID-527 through terraform"
}

resource "aws_kinesis_firehose_delivery_stream" "cid527fail" {
  name        = "terraform-kinesis-delivery-stream-fail"
  destination = "extended_s3"
  extended_s3_configuration {
    role_arn    = aws_iam_role.cid527kinesisrole.arn
    bucket_arn  = aws_s3_bucket.cid527bucket.arn
    # Ensure aws_kinesis_firehose_delivery_stream has an attribute extended_s3_configuration which has an attribute extended_s3_configuration.kms_key_arn
  }
}