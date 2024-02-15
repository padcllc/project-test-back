output "repository_url" {
  value = aws_ecr_repository.my_ecr_repository.repository_url
}
output "aws_route53_zone" {
  value = data.aws_route53_zone.my_zone
}

