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
