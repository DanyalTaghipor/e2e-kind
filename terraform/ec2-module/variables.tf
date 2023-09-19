# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "key_pair_name" {
  type        = string
  description = "Desired Key Pair Name"
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

  description = "Different AMIs' Filters"
}

variable "desired_os_name" {
  type        = string
  description = "Default Desired OS Name (It Should Exist As One of The ami_filters' Keys)"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "Default Region"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Default Instance Type"
}

variable "number_of_instances" {
  type        = number
  default     = 1
  description = "Number of Instances To Create"
}