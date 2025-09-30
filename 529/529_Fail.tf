resource "aws_launch_configuration" "cid529launchconfigfail" {
  name              = "terraform-launch-config-pass"
  image_id          = "ami-06b09bfacae1453cb"
  instance_type     = "t2.micro"
  enable_monitoring = false     # Ensure aws_launch_configuration has an attribute enable_monitoring set to true
}