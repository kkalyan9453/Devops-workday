provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo-server" {
    ami = "ami-01816d07b1128cd2d"
    instance_type = "t2.micro"
    key_name = "key value Dec" 
    security_groups = [ "demo-sg" ]  
}

resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "ssh-port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  description = "ssh access"
  security_group_id = aws_security_group.demo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.demo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
