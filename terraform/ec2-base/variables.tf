# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "Default Region"
}

variable "ami_filters" {
  type = map(object({
    default_user = string
    owner        = string
    filter_block_info = list(object({
      name   = string
      values = list(string)
    }))
  }))

  default = {
    "amazon_linux" = {
      default_user = "ec2-user"
      owner        = "amazon"
      filter_block_info = [
        {
          name   = "name"
          values = ["amzn2-ami-kernel-5.10-hvm-2.0.20230221.0-x86_64-gp2"]
        },
        {
          name   = "virtualization-type"
          values = ["hvm"]
        },
        {
          name   = "root-device-type"
          values = ["ebs"]
        },
        {
          name   = "architecture"
          values = ["x86_64"]
        },
      ]
    },
    "ubuntu" = {
      default_user = "ubuntu"
      owner        = "amazon"
      filter_block_info = [
        {
          name   = "name"
          values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230208"]
        },
        {
          name   = "virtualization-type"
          values = ["hvm"]
        },
        {
          name   = "root-device-type"
          values = ["ebs"]
        },
        {
          name   = "architecture"
          values = ["x86_64"]
        },
      ]
    }
  }

  description = "Two Different AMIs' (amazon_linux, ubuntu) Filters"
}

variable "desired_os_name" {
  type        = string
  default     = "ubuntu"
  description = "Default Desired OS Name (It Should Exist As One of The ami_filters' Keys)"
}
