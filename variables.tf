variable "public_key_path" {
  description = "aws key"
  default     = "~/.ssh/aws_dd.pub"
}

variable "key_name" {
  description = "aws ssh key"
  default     = "aws_key"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}

# Subnet
variable "aws_subnet" {
  default = {
    dev_main = "10.0.0.0/16"
    dev_public = "10.0.0.0/24"
    dev_a = "10.0.1.0/24"
  }
}

# AZ
variable "aws_az" {
  default = {
    dev_a = "us-west-2a"
    dev_b = "us-west-2b"
    dev_c = "us-west-2c"
  }
}

# AMI
variable "aws_amis" {
  default = {
    us-west-2 = "ami-6df1e514"
  }
}

#variable "eip" {
#  default = {
#    admin = "eipalloc-27e2011a"               #35.160.30.102
#  }
#}

variable "bucket_name" {
  default = "dd-state"
  description = "terraform remote state files"
}
