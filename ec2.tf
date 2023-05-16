resource "aws_instance" "nginxserver" {
  #ami = lookup(var.amis_map,"ubuntu")
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  count          = length(var.publicssubentscidrs)
  subnet_id      = element(aws_subnet.cywarevpcpublicsubnets[*].id, count.index)
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  user_data = file("install-docker.sh")
  key_name = "webserver"
  
  tags = merge(var.commantags,
    {
      "Name" = "Nginx-Server"
    }
  )

}



