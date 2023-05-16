output "alb_arn" {
    value = aws_lb.nginx_lb.dns_name
    description = "Nginx Server ALB ARN"
}

output "nginx_server_publicip" {
   value = aws_instance.nginxserver[*].public_ip
   description = "Nginx Server Public IP"
}

output "webserversg_id" {
  value = aws_security_group.webserver_sg.id
  description = "Web Server SG Id"
}

output "aws_ami" {
  value = data.aws_ami.ubuntu.id
  description = "Ubuntu Latest AMI ID"
}
