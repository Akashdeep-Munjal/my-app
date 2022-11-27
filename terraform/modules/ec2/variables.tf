variable "ec2_instance_name" {
    type = string
  
}

variable "env" {
    type = string
  
}

variable "private_subnets" {
  type    = list(string)

}

variable "costcenter" {
    type    = string

}

variable "vpc_id" {
    type    = string

}

variable "ami_id" {
    type    = string

}


variable "ec2_instance_count" {
    type    = number

}

variable "instance_type" {
    type    = string

}

variable "elb_sg" {
    type = string
  
}

variable "user_data_file_path" {
    type = string

}

variable "user_data_docker_file_path" {
    type = list(string)

}