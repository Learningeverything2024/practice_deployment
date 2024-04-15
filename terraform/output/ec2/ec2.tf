terraform {
  backend "s3" {
      encrypt = false
      bucket = "apispocc-team1-bucket-demo"
      dynamodb_table = "Apispocc-team1-db-table"
      key = "path/path/terraform-tfstate-ec2"
      region = "us-east-1"
  }
}

resource "aws_security_group" "Apispocc-sg-demo" {
  name   = "HTTP and SSH"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# resource "tls_private_key" "rsa" {
# algorithm = "RSA"
# rsa_bits  = 4096
# }
# resource "local_file" "tf-key" {
# content  = tls_private_key.rsa.private_key_pem
# filename = "keypair"
# } 
resource "aws_instance" "Apispocc-ec2" {
  count = 2
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "key-pair2"
  subnet_id              = "${element(var.public-subnets-tf, count.index )}"
  vpc_security_group_ids      = [aws_security_group.Apispocc-sg-demo.id]
  associate_public_ip_address = true

  # tags = {
  #   Name = "test-tf"
  # }

  #count                  = 2
  #ami                    = "${data.aws_ami.centos.id}"
  #instance_type          = "${var.instance_type}"
  #key_name               = "${aws_key_pair.mytest-key.id}"
  #vpc_security_group_ids = ["${var.security_group}"]
  #subnet_id              = "${element(var.subnets, count.index )}"
  #user_data              = "${data.template_file.init.rendered}"

  #tags = {
  #  Name = "my-instance-${count.index + 1}"
  #}
#}

  user_data = <<-EOF
  #!/bin/bash -ex

  amazon-linux-extras install nginx1 -y
  echo "<h1>$(curl https://api.kanye.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    Name =  "${var.ec2_name}-${count.index + 1}-ec2"
  }
}