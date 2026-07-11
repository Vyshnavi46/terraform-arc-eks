terraform {

  backend "s3" {
    bucket = "arc-eks-poc-vysh"
    key    = "arc/terraform.tfstate"
    region = "ap-south-1"
  }
}