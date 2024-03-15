locals {
  namespace = "${var.environment}-devops-ic-bastion"

  # The AMI image ID
  image_id = "ami-08569b978cc4dfa10"

  # The instance type
  instance_type = "t3.nano"

  # The minimum number of instances
  min_instance_count = 1

  # The maximum number of instances
  max_instance_count = 1

  # The desired number of instances
  instance_desired_count = 1
}
