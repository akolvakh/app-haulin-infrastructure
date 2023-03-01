output "offices_external_cidrs" {
  description = "CIDRs/IPS of Team"
  value       = [ 
                  "159.89.10.121/32", //GitLab
                  "136.243.21.61/32", //GitLab
                  "3.236.199.224/32", //VPN old
                  "44.200.19.111/32", //OPENVPN Marketplace (actual vpn)
                ]
}
