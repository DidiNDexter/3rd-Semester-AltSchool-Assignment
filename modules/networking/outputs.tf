output "test_public_subnet" {
  value = aws_subnet.test_public_subnet.id
}

output "allow_all" {
  value = aws_security_group.allow_all.id
}
