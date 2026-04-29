output "state_bucket_name" {
    value = aws_s3_bucket.tf_state.bucket

  
}

output "state_bucket_arn" {
  description = "ARN of the S3 bucket "
  value       = aws_s3_bucket.tf_state.arn
}

output "dynamodb_table_name" {
  description = "name of the DynamoDB table for state locking"
  value       = aws_dynamodb_table.tf_locks.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDb "
  value       = aws_dynamodb_table.tf_locks.arn
}

output "aws_region" {
  description = "region thee resources were created in"
  value       = var.aws_region
}