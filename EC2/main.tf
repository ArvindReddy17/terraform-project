resource "tls_private_key" "ssh_key" {
  rsa_bits  = 4096
  algorithm = "RSA"
}
//this above step is used to create a public and private key using TLS provider not AWS

resource "aws_key_pair" "key" { 
  key_name   = var.KEY_PAIR
  public_key = tls_private_key.ssh_key.public_key_openssh
}
//this above step is used to upload the public key into aws

resource "local_file" "pem" {
  filename = "${path.module}/${aws_key_pair.key.key_name}.pem"
    content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0400"
}
//this above step to store private key into local

resource "aws_security_group" "ec2-secuuu" {
    vpc_id = var.VPC_ID
    description = "sg for EC2 machine"
    name = "ec2-security-group"
  ingress  {
    from_port = 0
    to_port = 0
    protocol = -1
    description = "allow all traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allowing the 8080 port for jenkins"
  }
   ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}


resource "aws_instance" "EC2" {
 ami = var.AMI_ID
  associate_public_ip_address = true
  key_name = aws_key_pair.key.key_name
  user_data_base64 = filebase64("${path.module}/upload.sh")
  instance_type = var.instance_typee
  vpc_security_group_ids = [aws_security_group.ec2-secuuu.id]
  subnet_id = var.public_subnet
 tags = {
    Name = var.ec2_name
  }
}