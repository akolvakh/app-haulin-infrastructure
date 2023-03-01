# # --------------------------------------------------------------
# # Certificates
# # --------------------------------------------------------------
# resource "aws_acm_certificate" "this" {
#   # subject_alternative_names = ["*.${var.environment}.ajuma.local"]
#   domain_name               = var.alias[0]
#   #TODO
#   # certificate_authority_arn = var.certificate_authority_arn
#   // change it
#   # validation_method = "EMAIL" //DNS
#   validation_method = "DNS" //DNS

#   lifecycle {
#     create_before_destroy = true
#   }
# }