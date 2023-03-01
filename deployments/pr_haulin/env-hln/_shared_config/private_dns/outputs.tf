output "admin_graphql" {
  value = {
    dev     = "d-static-alfa-mb-1.zysbox.dev",
    staging = "s-static-alfa-mb-1.zysbox.dev",
    prod    = "static-admin-mb-1.phoenix.com"
    qa      = "q-static-alfa-mb-1.zysbox.dev"
  }
  description = "Admin appsync private DNS endpoint"
}

output "app_graphql" {
  value = {
    dev     = "d-static-alf-mb-1.zysbox.dev",
    staging = "s-static-alf-mb-1.zysbox.dev",
    prod    = "alf-mb-1.phoenix.com",
    qa      = "q-static-alf-mb-1.zysbox.dev"
  }
  description = "Admin appsync private DNS endpoint"
}
