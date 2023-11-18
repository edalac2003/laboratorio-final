# VPC CIDR Block
variable "vpc_cidr" {
  default = "172.30.0.0/16"
}

# Subnet 1 CIDR Block
variable "subnet_1_cidr" {
  default = "172.30.0.0/24"
}

# Subnet 2 CIDR Block
variable "subnet_2_cidr" {
  default = "172.30.1.0/24"
}

########## EC2 Instance Ubuntu #########

# KeyPair
# Buscar el nombre válido
variable "aws_keypair" {
  default = "KP_PRACTICE_20230930"
}
# Ubuntu AMI
variable "ec2_Ubuntu_ami" {
  default = "ami-0fc5d935ebf8bc3bc"
}
# EC2 Ubuntu Instance quantity
variable "ec2_Ubuntu_instance_quantity" {
  default = 1
}
# EC2 Ubuntu Instance Name
variable "ec2_Ubuntu_instance_name" {
  default = "Amazon Linux Ubuntu Laboratorio Final VSCode"
}
# EC2 Ubuntu Instance Type
variable "ec2_Ubuntu_instance_type" {
  default = "t2.micro"
}
# EC2 Ubuntu EBS Name
variable "ec2_Ubuntu_ebs_name" {
  default = "/dev/sda1"
}
# EC2 Ubuntu EBS Size
variable "ec2_Ubuntu_ebs_size" {
  default = 10
}
#EC2 Ubuntu EBS Type
variable "ec2_Ubuntu_ebs_type" {
  default = "gp2"
}