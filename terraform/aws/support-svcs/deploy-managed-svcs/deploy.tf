module "deploy_rds" {
  count = length(local.rds_services) > 0 ? 1 : 0
  source  = "../deploy-rds"
  deployment_name = var.deployment_name
  tags = var.tags
  rds_services = local.rds_services
  security_group_id = aws_security_group.managed_svcs.id
  private_subnets = module.base_infra.private_subnets
}

module "ubuntu_focal_ami" {
  source  = "../../ami-ubuntu"
  release = "20.04"
}

module "base_infra" {
  source  = "../../base-infra"
  cluster_name = var.deployment_name
  tags = var.tags
  vpc_cidr = var.vpc_cidr
  create_public_zone = false
  create_private_zone = false
  manage_parent_domain = false
  manage_parent_domain_ns = false
  az_count = var.az_count
  bastion_ami = module.ubuntu_focal_ami.id
  create_haproxy_dns_record = false
  configure_route_53 = false
}