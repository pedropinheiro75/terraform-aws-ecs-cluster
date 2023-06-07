locals {
  cluster_name = var.enabled ? module.ecs_cluster.name : ""
}

module "ecs_cluster" {
  source  = "../.."
  enabled = var.enabled

  name        = var.name
  suffix      = var.suffix
  environment = var.environment

  container_insights_enabled      = true
  capacity_providers_fargate      = true
  capacity_providers_fargate_spot = true
}
