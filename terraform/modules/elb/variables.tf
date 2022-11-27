variable "elb_name" {
    type = string
  
}

variable "env" {
    type = string
  
}

variable "public_subnets" {
  type    = list(string)

}

variable "costcenter" {
    type    = string

}

variable "vpc_id" {
    type    = string

}

variable "ec2_instance_ids" {
    type = list(string)
  
}