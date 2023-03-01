#--------------------------------------------------------------
# Static IPs
#--------------------------------------------------------------
output "static_ip_app_dns_name" {
  value = {
    "dev" = {
      "dns_name" = "d-static-alf-mb-1.zysbox.dev"
    },
    "qa" = {
      "dns_name" = "q-static-alf-mb-1.zysbox.dev"
    },
    "staging" = {
      "dns_name" = "s-static-alf-mb-1.zysbox.dev"
    },
    "prod" = {
      "dns_name" = "static-alf-mb-1.phoenix.com"
    }
  }
  description = "for vpn proxy service, DNS name associated with static IP addr for APP. Should be VPN only in dev/stage. In prod to not be used"
}

output "static_ip_admin_dns_name" {
  value = {
    "dev" = {
      "dns_name" = "d-static-alfa-mb-1.zysbox.dev"
    },
    "qa" = {
      "dns_name" = "q-static-alfa-mb-1.zysbox.dev"
    },
    "staging" = {
      "dns_name" = "s-static-alfa-mb-1.zysbox.dev"
    },
    "prod" = {
      "dns_name" = "static-admin-mb-1.phoenix.com"
    }
  }

  description = "for vpn proxy service, DNS name associated with static IP addr for ADMIN. Should be VPNOnly"
}

output "static_ip_admin_rest_dns_name" {
  value = {
    "dev" = {
      "dns_name" = "d-static-alfa-r-mb-1.zysbox.dev"
    },
    "qa" = {
      "dns_name" = "q-static-alfa-r-mb-1.zysbox.dev"
    },
    "staging" = {
      "dns_name" = "s-static-alfa-r-mb-1.zysbox.dev"
    },
    "prod" = {
      "dns_name" = "static-admin-r-mb-1.phoenix.com"
    }
  }

  description = "for vpn proxy service, DNS name associated with static IP addr for ADMIN REST entry point(temp). Should be VPN"
}

output "static_ip_admin_ui_dns_name" {
  value = {
    "dev" = {
      "dns_name" = "d-static-alfa-cf-mb-1.zysbox.dev"
    },
    "qa" = {
      "dns_name" = "q-static-alfa-cf-mb-1.zysbox.dev"
    },
    "staging" = {
      "dns_name" = "s-static-alfa-cf-mb-1.zysbox.dev"
    },
    "prod" = {
      "dns_name" = "static-admin-cf-mb-1.phoenix.com"
    }
  }

  description = "for vpn proxy service, DNS name associated with static IP addr for ADMIN UI entry point(temp). Should be VPN"
}