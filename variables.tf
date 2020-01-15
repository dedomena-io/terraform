variable "public_key_path" {
  description = "aws key"
  default     = "~/.ssh/aws_dd.pub"
}

variable "key_name" {
  default     = "aws_key"
}

variable "aws_region" {
  default     = "us-west-2"
}

variable "domain" {
  default     = "krolm.com"
}

variable "dns_ttl" {
  default = "300"
}

# Subnet
variable "aws_subnet" {
  default = {
    dev_main = "10.0.0.0/16"
    dev_public = "10.0.0.0/24"
    dev_a = "10.0.1.0/24"
    dev_b = "10.0.2.0/24"
    dev_c = "10.0.3.0/24"
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

# Security groups IPs
variable "cidr_block" {
  type = list
  default = [
    "10.0.0.0/16",
    "8.8.8.8/32"
  ]
}

# Kubernetes
variable "cluster-name" {
  type    = string
  default = "dd-dev-cluster"
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
