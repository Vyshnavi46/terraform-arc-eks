module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = var.vpc_name

  cidr = var.vpc_cidr

  azs = var.azs

  private_subnets = var.private_subnets

  public_subnets = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway

  single_nat_gateway = var.single_nat_gateway

  enable_dns_hostnames = var.enable_dns_hostnames

  public_subnet_tags = {

    "kubernetes.io/role/elb" = "1"

    "kubernetes.io/cluster/${var.cluster_name}" = "shared"

  }

  private_subnet_tags = {

    "kubernetes.io/role/internal-elb" = "1"

    "kubernetes.io/cluster/${var.cluster_name}" = "shared"

  }

  tags = local.common_tags

}

module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name = var.cluster_name

  kubernetes_version = var.kubernetes_version

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnets

  endpoint_private_access = var.endpoint_private_access

  endpoint_public_access = var.endpoint_public_access

  authentication_mode = "API_AND_CONFIG_MAP"

  enable_irsa = true

  enable_cluster_creator_admin_permissions = true

  create_kms_key = true

  enabled_log_types = [

    "api",

    "audit",

    "authenticator",

    "controllerManager",

    "scheduler"

  ]

  cloudwatch_log_group_retention_in_days = 30

  create_cloudwatch_log_group = true

  addons = local.addons

  eks_managed_node_groups = local.eks_managed_node_groups

  node_iam_role_additional_policies = local.node_iam_role_additional_policies

  tags = local.common_tags

}