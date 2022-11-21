resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  capacity_providers = var.cluster_capacity_providers

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = var.default_tags
}


resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = var.cluster_name

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  inline_policy {
    name   = "secretsmanager-gitlab"
    policy = data.aws_iam_policy_document.inline_policy.json
  }

  tags = var.default_tags
}


resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


################################################################################
# Data Sources
################################################################################


data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


data "aws_iam_policy_document" "inline_policy" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      "arn:aws:secretsmanager:eu-central-1:id:secret:secret_name"
    ]
  }
}
