#--------------------------------------------------------------
# Notes
#--------------------------------------------------------------
#this type of ami only for us-east-1

#--------------------------------------------------------------
# Bastion
#--------------------------------------------------------------
module "bastion" {
    source = "../../../../../../libft/generic-modules/bastion"
    instance_name     = "${module.label.id}_db_quartz_bastion"
    ami               = var.ami #us-east-1 20.04
    subnet_ids        = var.outputs_vpc_public_subnets
    security_group_id = module.bastion_sg.sg_id
    env               = var.label["Environment"]
}