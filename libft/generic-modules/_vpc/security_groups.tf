#We want only 443/80 IN for our VPCs and only from privileged (VPN) ip range in DEV/QA
# NACLs are stateless, and ephemeral ports used by browsers/IOs/Android are too wide range, not much point.
# So - use security groups. ALB has to import those from VPC module "outputs" and use. But ALB can also add additional sec groups and what the point?
# we endup with configuratino split among two modules
# dont do it in VPC module - enforce incoming intenet policy on ALB modules