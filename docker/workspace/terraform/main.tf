
resource "aws_vpc" "terraform-sample" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "terraform-sample-vpc"
  }
}

resource "aws_security_group" "terraform-sample" {
  vpc_id = aws_vpc.terraform-sample.id
  name = "terraform-sample-sg"

  tags = {
    "Name" = "terraform-sample-sg"
  }
}

resource "aws_security_group_rule" "terraform-sample-in-ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.terraform-sample.id
}

resource "aws_security_group_rule" "terraform-sample-in-icmp" {
  type = "ingress"
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.terraform-sample.id
}

resource "aws_security_group_rule" "terraform-sample-out-all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.terraform-sample.id
}

resource "aws_internet_gateway" "terraform-sample-public" {
  vpc_id = aws_vpc.terraform-sample.id

  tags = {
    "Name" = "terraform-sample-igw"
  }
}

resource "aws_route_table_association" "terraform-sample-public-1a" {
  subnet_id = aws_subnet.terraform-sample-public-1a.id
  route_table_id = aws_route_table.terraform-sample-public-1a.id
}

resource "aws_subnet" "terraform-sample-public-1a" {
  vpc_id = aws_vpc.terraform-sample.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  availability_zone = "ap-northeast-1a"
  tags = {
    "Name" = "terraform-sample-subnet-public-1a"
  }
}

resource "aws_route_table" "terraform-sample-public-1a" {
  vpc_id = aws_vpc.terraform-sample.id

  tags = {
    "Name" = "terraform-sample-subnet-public-1a"
  }
}

resource "aws_route" "terraform-sample-public-1a" {
  route_table_id = aws_route_table.terraform-sample-public-1a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.terraform-sample-public.id
}

resource "aws_instance" "terraform-sample-public-1a-main" {
  ami = data.aws_ami.terraform-sample.image_id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.terraform-sample-public-1a.id
  key_name = aws_key_pair.terraform-sample-public-1a-main.id
  vpc_security_group_ids = [ aws_security_group.terraform-sample.id ]

  tags = {
    "Name" = "terraform-sample"
  }
}

resource "aws_key_pair" "terraform-sample-public-1a-main" {
  key_name = "id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "terraform-sample" {
  owners = [ "amazon" ]
  most_recent = true

  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }

  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*" ]
  }

  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }

  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
}
