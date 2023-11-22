# tfsec:ignore:aws-ec2-no-public-ip
resource "aws_launch_configuration" "bastion_instance" {
  name_prefix                 = local.namespace
  key_name                    = local.namespace
  image_id                    = local.image_id
  instance_type               = local.instance_type
  security_groups             = var.instance_security_group_ids
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }
}

resource "aws_autoscaling_group" "bastion_instance" {
  launch_configuration = aws_launch_configuration.bastion_instance.name
  name                 = local.namespace
  min_size             = local.min_instance_count
  max_size             = local.max_instance_count
  desired_capacity     = local.instance_desired_count
  vpc_zone_identifier  = var.subnet_ids

  tag {
    key                 = "Name"
    value               = local.namespace
    propagate_at_launch = true
  }
}
