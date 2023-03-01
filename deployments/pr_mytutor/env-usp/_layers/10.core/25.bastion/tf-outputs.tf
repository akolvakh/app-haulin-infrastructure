output "bastion_ip" {
  value = module.bastion.ec2_instance.public_ip
}