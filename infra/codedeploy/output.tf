output "codedeploy_app" {
    value = aws_codedeploy_app.deploy.arn
  
}

output "codedeploy_name" {
    value = aws_codedeploy_app.deploy.name
  
}