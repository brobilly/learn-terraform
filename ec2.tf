resource "aws_instance" "web_server_a" {
  ami             = "ami-05c969369880fa2c2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.public_sg.id]
  subnet_id       = aws_subnet.subnet_a.id

  tags = {
    name = "web-server-a"
  }

  user_data = <<-EOF
#!/bin/bash
sudo apt-get update -y
sudo install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF

}

resource "aws_instance" "web_server_c" {
  ami             = "ami-05c969369880fa2c2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.public_sg.id]
  subnet_id       = aws_subnet.subnet_c.id

  tags = {
    name = "web-server-c"
  }

  user_data = <<-EOF
#!/bin/bash
sudo apt-get update -y
sudo apt install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF

}
