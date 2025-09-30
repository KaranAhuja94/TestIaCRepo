resource "aws_neptune_cluster" "cid531pass" {
  cluster_identifier                  = "cid-531-build-time-pass"
  engine                              = "neptune"
  # Ensure aws_neptune_cluster resource has attribute storage_encrypted set to true and attribute kms_key_arn has key arn specified
  storage_encrypted = true
  kms_key_arn = "arn:aws:kms:us-east-1:860454016470:key/0ee1cd6e-3e7d-4582-b3a5-44b792f6943f"
}