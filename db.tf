resource "aws_db_instance" "terra_db" {
  allocated_storage    = 4
  db_name              = "terra_db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "admin"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
