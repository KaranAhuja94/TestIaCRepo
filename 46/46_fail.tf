resource "aws_s3_bucket" "example" {
  bucket = "example-bucket"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
    mfa_delete = "Enabled"          # 255 - Ensure aws_s3_bucket_versioning has versioning_configuration.mfa_delete is set to 'Enabled' and bucket is set to aws_s3_bucket resource
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.example.id
  access_control_policy {
    #grant {               # 45 - Ensure aws_s3_bucket_acl does not have any grant present
     # grantee {
        #id   = data.aws_canonical_user_id.current.id
       # type = "CanonicalUser"
      #}
     # permission = "READ"
   # }

    #grant {
     # grantee {
      #  type = "Group"
      #  uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
     # }
     # permission = "READ_ACP"
   # }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.example.id     # 46 - Ensure aws_s3_bucket_policy doesn't have any wildcard(*) in policy principal 
                                        # 57 - Ensure aws_s3_bucket_policy.policy has Effect set to 'Deny', Principal set to '*' or { "AWS": "*" }, Action set to 's3:*' and Condition.Bool set to { "aws:SecureTransport": "false" }
  policy = <<POLICY
 { "Version": "2012-10-17", "Statement": [{ "Effect": "Deny", "Principal": { "AWS": "*" }, "Action": "s3:*", "Resource": [ "arn:aws:s3:::[Bucket-Name]", "arn:aws:s3:::[Bucket-Name]/*" ], "Condition": { "Bool": { "aws:SecureTransport": "false" } } }] } 
POLICY
}