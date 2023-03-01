output "vpn_clients_range" {
  description = "VPN clients"
  value       = "10.200.0.0/22"
}

output "vpn_vpc_cidr" {
  description = "VPN VPC"
  value       = { primary = "10.200.4.0/22", secondary = "10.200.12.0/22" }
}

output "vpn_vpc_eip" {
  description = "We use split vpn, so for connection to DEV/QA ALBs we send traffic over internet from VPN network EIP to DEV/QA envs static EIP."
  value       = { primary = "18.219.144.79", secondary = "3.142.234.231" }
}
