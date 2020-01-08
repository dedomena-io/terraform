### Bastion instance
resource "aws_instance" "bastion" {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    host     = self.public_ip
  }

  instance_type = "t2.micro"

  # Lookup the correct AMI based on the region
  # we specified
  ami = lookup(var.aws_amis, var.aws_region)

  # The name of our SSH keypair we created above.
  key_name = aws_key_pair.auth.id

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = [aws_security_group.ping.id,aws_security_group.ssh.id]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = aws_subnet.public.id

  # We run a remote provisioner on the instance after creating it.
  # Fix the hostname
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sudo hostname ${aws_instance.bastion.tags.Name} && echo ${aws_instance.bastion.tags.Name} |sudo tee /etc/hostname",
      "sudo echo 127.0.0.1 ${aws_instance.bastion.tags.Name}.dev.dedomena.io ${aws_instance.bastion.tags.Name} |sudo tee -a /etc/hosts",
      "sudo echo ${aws_instance.bastion.private_ip} ${aws_instance.bastion.tags.Name}.dev.dedomena.io ${aws_instance.bastion.tags.Name} |sudo tee -a /etc/hosts"
    ]
  }

  # Name tag
  tags = {
    Name        = "bastion"
  }
}

# DNS record
resource "aws_route53_record" "bastion_private" {
   zone_id = aws_route53_zone.dev.zone_id
   name = "bastion.dev.dedomena.io"
   type = "A"
   ttl = "300"
   records = [aws_instance.bastion.private_ip]
}

resource "aws_route53_record" "bastion_public" {
   zone_id = aws_route53_zone.main.zone_id
   name = "bastion.dedomena.io"
   type = "A"
   ttl = "300"
   records = [aws_instance.bastion.public_ip]
}
