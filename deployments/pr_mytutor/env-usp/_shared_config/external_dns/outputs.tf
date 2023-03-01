output "public_alb" {
  value = {
    staging = "s-alf-mb-1.zysbox.dev."
    dev     = "d-alf-mb-1.zysbox.dev"
    prod    = "alf-mb-1.phoenix.com"
    qa      = "q-alf-mb-1.zysbox.dev"
  }
  description = "Admin alb external DNS endpoint"
}

output "admin_alb" {
  value = {
    staging = "s-alfa-mb-1.zysbox.dev"
    dev     = "d-alfa-mb-1.zysbox.dev"
    prod    = "alfa-mb-1.phoenix.com"
    qa      = "q-alfa-mb-1.zysbox.dev"
  }
  description = "Public alb external DNS endpoint"
}

output "admin_ui" {
  value = {
    dev     = "d-static-alfa-cf-mb-1.zysbox.dev"
    staging = "s-static-alfa-cf-mb-1.zysbox.dev"
    prod    = "static-admin-cf-mb-1.phoenix.com"
    qa      = "q-static-alfa-cf-mb-1.zysbox.dev"
  }
}
