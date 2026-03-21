resource "aws_iam_role_policy" "ecs_secrets" {
  name = "ecs-secrets-policy"
  role = aws_iam_role.ecs_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue"
      ]
      Resource = data.aws_secretsmanager_secret.db_password.arn
    }]
  })
}

resource "aws_iam_role_policy" "ecs_cloudwatch" {
  name = "ecs-cloudwatch-policy"
  role = aws_iam_role.ecs_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "arn:aws:logs:eu-west-2:*:log-group:/ecs/*"
    }]
  })
}

resource "aws_iam_role_policy" "ecs_cloudwatch" {
  name = "ecs-cloudwatch-policy"
  role = aws_iam_role.ecs_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "arn:aws:logs:eu-west-2:*:log-group:/ecs/*"
    }]
  })
}