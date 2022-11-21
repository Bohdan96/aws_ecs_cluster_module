provider "aws" {
  region  = local.region
  profile = ""
}

locals {
  region = "eu-central-1"
}


################################################################################
# ECS Cluster Module
################################################################################


module "ecs_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace   = "stark"
  environment = "dev"
  name        = "ecs"

  label_order = ["namespace", "environment", "name"]
  delimiter   = "-"

  tags = var.default_tags
}


module "ecs_cluster_complete" {
  source = "../../"

  cluster_name = module.ecs_label.id

  default_tags = merge(
    {
      "Component" = "ecs"
    },
    module.ecs_label.tags
  )
}
