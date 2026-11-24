output "private_ips" {
  value = {
    api = aws_instance.api.private_ip
    web = aws_instance.web.private_ip
  }
}

output "instance_ids" {
  value = {
    api_instance_id = aws_instance.api.id
    web_instance_id = aws_instance.web.id
  }
}
