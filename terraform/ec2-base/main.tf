provider "aws" {
  region = var.region
}

module "ec2-instance" {
  source = "../ec2-module"

  region              = var.region
  ami_filters         = var.ami_filters
  key_pair_name       = "ansible"
  desired_os_name     = var.desired_os_name
  number_of_instances = startswith(var.region, "us-") ? 0 : 1
}