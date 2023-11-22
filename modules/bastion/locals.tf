locals {
  namespace = "devops-ic-bastion"

  # The AMI image ID
  image_id = "ami-08569b978cc4dfa10"

  # The instance type
  instance_type = "t3.nano"

  # The desired number of the instance
  instance_desired_count = 1

  # The minimum number of the instance
  min_instance_count = 1

  # The maximum number of the instance
  max_instance_count = 1
}
