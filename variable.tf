variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "vpccidr" {
  type        = string
  default     = "10.1.0.0/24"
  description = "CIDR Of VPC "
}

variable "publicssubentscidrs" {
  type    = list(string)
  default = ["10.1.0.0/26", "10.1.0.64/26"]
}

variable "privatesubentscidrs" {
  type    = list(string)
  default = ["10.1.0.128/26", "10.1.0.192/26"]
}

variable "commantags" {
  type = map(string)
  default = {
    "Organization" = "cyware",
    "Environmet"  = "Dev"
  }
  description = "Comman Tags"
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "aws_availabilty_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}


#variable "amis_map" {
# type = map(string)
#  default = {
#    "redhat" = "ami-0e07dcaca348a0e68", 
#    "ubuntu" = "ami-0f8ca728008ff5af4"
#  }
#}




