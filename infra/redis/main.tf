resource "aws_elasticache_replication_group" "this" {
  replication_group_id = "${var.name}-redis"
  description = "Redis"

  engine         = "redis"
  engine_version = var.engine_version
  node_type      = var.node_type
  port           = var.port

  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [var.redis_sg]

  num_cache_clusters         = var.num_cache_clusters
  multi_az_enabled           = var.multi_az_enabled
  automatic_failover_enabled = var.automatic_failover_enabled


  at_rest_encryption_enabled = true
  transit_encryption_enabled = false

  tags = {
    Name = "${var.name}-redis"
  }
}


resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.name}-redis-subnets"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.name}-redis-subnets"
  }
}
