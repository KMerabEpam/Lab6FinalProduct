provider "aws" {
  alias  = "primary"
  region = "eu-central-1a"
}

provider "aws" {
  alias  = "secondary"
  region = "eu-central-1b"
}

resource "aws_rds_global_cluster" "webserver" {
  global_cluster_identifier = "global-test"
  engine                    = "aurora-postgresql"
  engine_version            = "11.9"
  database_name             = "ws_db"
}

resource "aws_rds_cluster" "primary" {
  provider                  = aws.primary
  engine                    = aws_rds_global_cluster.webserver.engine
  engine_version            = aws_rds_global_cluster.webserver.engine_version
  cluster_identifier        = "test-primary-cluster"
  master_username           = "admin"
  master_password           = "pass123"
  database_name             = "ws_db"
  global_cluster_identifier = aws_rds_global_cluster.webserver.id
  db_subnet_group_name      = "default"
}

resource "aws_rds_cluster_instance" "primary" {
  provider             = aws.primary
  engine               = aws_rds_global_cluster.webserver.engine
  engine_version       = aws_rds_global_cluster.webserver.engine_version
  identifier           = "test-primary-cluster-instance"
  cluster_identifier   = aws_rds_cluster.primary.id
  instance_class       = "db.r4.large"
  db_subnet_group_name = "default"
}

resource "aws_rds_cluster" "secondary" {
  provider                  = aws.secondary
  engine                    = aws_rds_global_cluster.webserver.engine
  engine_version            = aws_rds_global_cluster.webserver.engine_version
  cluster_identifier        = "test-secondary-cluster"
  global_cluster_identifier = aws_rds_global_cluster.webserver.id
  skip_final_snapshot       = true
  db_subnet_group_name      = "default"

  depends_on = [
    aws_rds_cluster_instance.primary
  ]

resource "aws_rds_cluster_instance" "secondary" {
  provider             = aws.secondary
  engine               = aws_rds_global_cluster.webserver.engine
  engine_version       = aws_rds_global_cluster.webserver.engine_version
  identifier           = "test-secondary-cluster-instance"
  cluster_identifier   = aws_rds_cluster.secondary.id
  instance_class       = "db.r4.large"
