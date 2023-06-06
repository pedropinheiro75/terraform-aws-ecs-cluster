locals {
  cluster_name = var.enabled ? module.ecs_cluster.name : ""
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "1.2.0"

  enabled = var.enabled

  name        = var.name
  environment = var.environment

  ipv4_primary_cidr_block = "172.16.0.0/16"
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.0.4"

  enabled = var.enabled

  name        = var.name
  environment = var.environment

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = [module.vpc.igw_id]
  ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
  nat_gateway_enabled  = false
  nat_instance_enabled = false
}

module "ecs_cluster" {
  source  = "../.."
  enabled = var.enabled

  name        = var.name
  environment = var.environment

  container_insights_enabled      = true
  capacity_providers_fargate      = true
  capacity_providers_fargate_spot = true
}
