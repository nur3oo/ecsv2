resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_db_instance" "rds" {
  identifier        = "prod-postgres"
  engine            = "postgres"
  engine_version    = "16.2"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = data.aws_secretsmanager_secret.db_password.secret.string

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  multi_az               = true
  publicly_accessible    = false
  deletion_protection    = false
  skip_final_snapshot    = false
  final_snapshot_identifier = "prod-postgres"

  backup_retention_period = 7

  tags = {
    Name = "prod-postgres"
  }
}

data "aws_secretsmanager_secret" "db_password" {
  name = "database_url"  # pass for my database
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}