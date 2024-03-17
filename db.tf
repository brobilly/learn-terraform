resource "aws_db_instance" "terra_db" {
  allocated_storage      = 10
  storage_type           = "gp2"
  db_name                = "terra_db"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "password"
  db_subnet_group_name   = "db_subnet"
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
}

