############# VPC ##############

resource "aws_vpc" "VPCLaboratorioFinal" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "VPCLaboratorioFinal"
  }
}


############# Subnets #############

resource "aws_subnet" "SUBNET_LaboratorioFinal_1_VSCode" {
  vpc_id = aws_vpc.VPCLaboratorioFinal.id
  cidr_block = "${var.subnet_1_cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "SUBNET_LaboratorioFinal_1_VSCode"
    "Env" = "LAB"
  }
  depends_on = [
    aws_vpc.VPCLaboratorioFinal
  ]
}

resource "aws_subnet" "SUBNET_LaboratorioFinal_2_VSCode" {
  vpc_id = aws_vpc.VPCLaboratorioFinal.id
  cidr_block = "${var.subnet_2_cidr}"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "SUBNET_LaboratorioFinal_2_VSCode"
    "Env" = "LAB"
  }
  depends_on = [
    aws_vpc.VPCLaboratorioFinal
  ]
}

############# Internet Gateway #############

resource "aws_internet_gateway" "IG_LaboratorioFinal_VSCode" {
  vpc_id = aws_vpc.VPCLaboratorioFinal.id
}

############# Route Table #############

resource "aws_route_table" "RT_LaboratorioFinal_VSCode" {
  vpc_id = aws_vpc.VPCLaboratorioFinal.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG_LaboratorioFinal_VSCode.id
  }
 depends_on = [aws_internet_gateway.IG_LaboratorioFinal_VSCode]
}

resource "aws_main_route_table_association" "RT_AssociationUbuntu" {
  route_table_id = aws_route_table.RT_LaboratorioFinal_VSCode.id
  vpc_id         = aws_vpc.VPCLaboratorioFinal.id
}

############# EC2 Security Group #############

resource "aws_security_group" "SG_UbuntuLaboratorioFinal_VSCode" {
  name = "SG_UbuntuITMLaboratorioFinal_VSCode"
  vpc_id = aws_vpc.VPCLaboratorioFinal.id
  ingress {
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
  }
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

############# EC2 Ubuntu Instance #############

resource "aws_instance" "EC2_Ubuntu_LaboratorioFinal_VSCode" {
  ami = "${var.ec2_Ubuntu_ami}"
  instance_type = "${var.ec2_Ubuntu_instance_type}"
  count = "${var.ec2_Ubuntu_instance_quantity}"
  subnet_id = aws_subnet.SUBNET_LaboratorioFinal_1_VSCode.id
  key_name = "${var.aws_keypair}"
  security_groups = [aws_security_group.SG_UbuntuLaboratorioFinal_VSCode.id]
  tags = {
    Name = "${var.ec2_Ubuntu_instance_name}"
  }
  user_data = <<EOF
#!/bin/bash
# Update and upgrade--> Operating System and TZ
apt-get update
apt-get upgrade -y
export TZ=America/Bogota
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get install -y tzdata
apt-get install -y unzip
# Install--> python3, pip package manager and virtualenv
apt-get install -y python3 python3-pip python3-virtualenv
# Create--> Python3 virtualenv
export VIRTUAL_ENV=/opt/SARA/
python3 -m virtualenv $VIRTUAL_ENV
export PATH="$VIRTUAL_ENV/bin:$PATH"
# Install--> jam-py package
python3 -m pip install jam.py
# Create SARA jam-project (Github download)
cd /opt/SARA
wget https://github.com/gustavoduque5537/laboratorio-final/archive/refs/heads/main.zip
unzip main.zip
# Run application
python /opt/SARA/laboratorio-final-main/app/server.py > /opt/SARA/laboratorio-final-main/app/output.log 2>&1 &
EOF
}

