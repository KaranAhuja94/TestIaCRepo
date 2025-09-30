resource "aws_neptune_cluster" "cid531fail" {
  cluster_identifier                  = "cid-531-build-time-fail"
  engine                              = "neptune"
  # Ensure aws_neptune_cluster resource has attribute storage_encrypted set to true and attribute kms_key_arn has key arn specified
  storage_encrypted = false
}