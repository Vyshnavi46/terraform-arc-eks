locals {

  common_tags = {
    Project     = "ARC"
    Environment = "POC"
    ManagedBy   = "Terraform"
    Owner       = "CloudOps"
  }

  addons = {

    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      before_compute = true
      most_recent    = true
    }

    eks-pod-identity-agent = {
      most_recent = true
    }

  }

  eks_managed_node_groups = {

    default = {

      desired_size = 2
      min_size     = 2
      max_size     = 4

      instance_types = [
        "t3.medium"
      ]

      capacity_type = "ON_DEMAND"

      ami_type = "AL2023_x86_64_STANDARD"

      disk_size = 50

      enable_bootstrap_user_data = true

      force_update_version = true

      labels = {
        role = "runner"
      }

      update_config = {
        max_unavailable_percentage = 50
      }

      node_repair_config = {
        enabled = true
      }

      tags = {
        workload = "github-runner"
      }

    }

  }

  node_iam_role_additional_policies = {

    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

    CloudWatchAgentServerPolicy = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

  }

}