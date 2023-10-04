# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "this" {
  #checkov:skip=CKV_AWS_136: There is no need to encrypt the ECR repository with a customer-managed KMS key
  name                 = local.namespace
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "main_policy" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = concat(local.primary_image_rules, local.secondary_image_rules, local.untagged_image_rules)
  })
}
