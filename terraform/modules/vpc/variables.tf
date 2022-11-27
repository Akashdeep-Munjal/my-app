variable "vpc_name" {
    type = string
  
}

variable "vpc_cidr" {
    type = string
  
}

variable "availability_zone_names" {
  type    = list(string)

}

variable "private_subnets" {
    type    = list(string)

}

variable "public_subnets" {
    type    = list(string)
  
}

variable "env" {
    type    = string
  
}


variable "costcenter" {
    type    = string
  
}