variable "vpc_name" {
  type    = string
  default = "my-app-vpc"

}

variable "vpc_cidr" {
  type    = string
  default = "10.50.0.0/16"

}

variable "availability_zone_names" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.50.0.0/20", "10.50.16.0/20", "10.50.32.0/20"]


}

variable "public_subnets" {
  type    = list(string)
  default = ["10.50.48.0/20", "10.50.64.0/20", "10.50.80.0/20"]


}

variable "env" {
  type    = string
  default = "dev"

}


variable "costcenter" {
  type    = string
  default = "c001"

}

variable "aws_region" {
  type    = string
  default = "ap-south-1"

}


variable "elb_name" {
  type    = string
  default = "my-app-elb"

}

variable "ami_id" {
  type    = string
  default = "ami-074dc0a6f6c764218"

}

variable "instance_type" {
  type    = string
  default = "t3a.micro"
}

variable "ec2_instance_name" {
  type    = string
  default = "my-app-instance"

}

variable "user_data_file_path" {
  type    = string
  default = "./files/app-install.sh"
}

variable "ec2_instance_count" {
  type    = number
  default = 3

}