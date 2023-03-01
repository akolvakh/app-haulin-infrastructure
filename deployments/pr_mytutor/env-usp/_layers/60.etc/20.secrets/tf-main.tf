#--------------------------------------------------------------
# Secrets
#--------------------------------------------------------------
# The map here can come from other supported configurations
# like locals, resource attribute, map() built-in, etc.
variable "secret_db" {
  default = {
    username            = "root"
    password            = "zQjbgXpPRtoyhshzcdI3"
    engine              = "postgres"
    host                = "phoenix-app-dev-new.cluster-cpewhy546lbt.us-east-1.rds.amazonaws.com"
    port                = "5432"
    db                  = "dev"
    dbClusterIdentifier = "phoenix-app-dev-new"
    userPoolId          = "us-east-1_0DcuU6kuk"
    quartz_port         = "5432",
    quartz_username     = "root",
    quartz_password     = "zQjbgXpPRtoyhshzcdI3",
    quartz_d            = "dev",
    quartz_host         = "dev-usp-quartz.cluster-cpewhy546lbt.us-east-1.rds.amazonaws.com"
  }

  type = map(string)
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode(var.secret_db)
}

resource "aws_secretsmanager_secret" "db" {
  name                    = "/${local.name_prefix}/db/credentials"
  recovery_window_in_days = 0
  tags                    = module.label.tags
  description             = <<-EOT
      Example
      username	          root
      password	          zQjbgXpPRtoyhshzcdI3
      engine	            postgres
      host	              phoenix-app-dev-new.cluster-cpewhy546lbt.us-east-1.rds.amazonaws.com
      port	              5432
      dbClusterIdentifier	phoenix-app-dev-new
      db                  dev
      
      {
        "username":"root",
        "password":"FtBeDzFyMDnL9LxKHXKG",
        "engine":"postgres",
        "host":"phoenix-app-staging-new.cluster-crvgofvimhj5.us-east-1.rds.amazonaws.com",
        "port":5432,
        "dbClusterIdentifier":"phoenix-app-staging-new",
        "db":"staging",
        "userPoolId":"us-east-1_0DcuU6kuk"
      }
      
      
    EOT
  lifecycle {
    ignore_changes = [
      id,
      arn
    ]
  }
}




resource "aws_secretsmanager_secret" "rds_lambda" {
  name                    = "/${local.name_prefix}/rds_lambda"
  recovery_window_in_days = 0
  tags                    = module.label.tags
  description             = <<-EOT
      Example
      username	          root
      password	          zQjbgXpPRtoyhshzcdI3
      engine	            postgres
      host	              phoenix-app-dev-new.cluster-cpewhy546lbt.us-east-1.rds.amazonaws.com
      port	              5432
      dbClusterIdentifier	phoenix-app-dev-new
      db                  dev
      userPoolId          us-east-1_L9Ssyqc4v
    EOT
  

  
  lifecycle {
    ignore_changes = [
      id,
      arn
    ]
  }
}



variable "secret_booknook" {
  default = {
    BOOKNOOK_API_URL                      = "https://api-qa.booknooklearning.com"
    BOOKNOOK_API-KEY-HEADER-NAME	        = "x-api-key"
    BOOKNOOK_API-KEY	                    = "098cbcaa-8f5e-4c77-809f-72fdc6d8e3f3"
    BOOKNOOK_API_VERSION	                = "2"
  }

  type = map(string)
}

resource "aws_secretsmanager_secret_version" "booknook" {
  secret_id     = aws_secretsmanager_secret.booknook.id
  secret_string = jsonencode(var.secret_booknook)
}

resource "aws_secretsmanager_secret" "booknook" {
  name                    = "/${local.name_prefix}/booknook"
  recovery_window_in_days = 0
  tags                    = module.label.tags
  description             = <<-EOT
      Example
      BOOKNOOK_API_URL	                      https://api-qa.booknooklearning.com
      BOOKNOOK_API-KEY-HEADER-NAME	          x-api-key
      BOOKNOOK_API-KEY	                      098cbcaa-8f5e-4c77-809f-72fdc6d8e3f3
      
      {
        "BOOKNOOK_API_URL":"https://api-qa.booknooklearning.com",
        "BOOKNOOK_API-KEY-HEADER-NAME":"x-api-key",
        "BOOKNOOK_API-KEY":"098cbcaa-8f5e-4c77-809f-72fdc6d8e3f3"
      }
    EOT
  
  lifecycle {
    ignore_changes = [
      id,
      arn
    ]
  }
}









# resource "aws_secretsmanager_secret" "firebase_dynamic_link_api_key" {
#   name                    = "/${local.name_prefix}/firebase/service_admin/dynamic_link_api_key"
#   recovery_window_in_days = 0 // while we setting up infra - cancel AAWS "you can not delete and recreate secret unless x days passed"
#   tags                    = module.label.tags
#   description             = "for generation dynamic link for Early access"
#   lifecycle {
#     ignore_changes = [
#       id,
#       arn
#     ]
#   }
# }
# resource "aws_secretsmanager_secret" "vpn_proxy_ssl_cert" {
#   name                    = "/${local.name_prefix}/vpn_proxy/cert"
#   recovery_window_in_days = 0 // while we setting up infra - cancel AWS "you can not delete and recreate secret unless x days passed"
#   tags                    = module.label.tags
#   description             = "wildcard SSL cert for vpn proxy.Shall we move it to params? Or join to key into one file and keepin secrets, or use ACM? to define.. ref TECHGEN-4612"
#   lifecycle {
#     ignore_changes = [
#       id,
#       arn
#     ]
#   }
# }
# resource "aws_secretsmanager_secret" "vpn_proxy_ssl_key" {
#   name                    = "/${local.name_prefix}/vpn_proxy/key"
#   recovery_window_in_days = 0 // while we setting up infra - cancel AWS "you can not delete and recreate secret unless x days passed"
#   tags                    = module.label.tags
#   description             = "wildcard SSL cert for vpn proxy.private key. ref TECHGEN-4612"
#   lifecycle {
#     ignore_changes = [
#       id,
#       arn
#     ]
#   }
# }
# resource "aws_secretsmanager_secret" "cognito_proxy_secret" {
#   name                    = "${var.aws_region}.${module.label.tags["Product"]}-app-cognito_proxy_secret"
#   recovery_window_in_days = 0 // while we setting up infra - cancel AWS "you can not delete and recreate secret unless x days passed"
#   tags                    = module.label.tags
#   description             = "Secret that will hold the value of application client secret"
#   lifecycle {
#     ignore_changes = [
#       id,
#       arn,
#       policy
#     ]
#   }
# }
# resource "aws_secretsmanager_secret" "csrf_token_to_user_identity" {
#   name                    = "/${local.name_prefix}/csrf_secret"
#   recovery_window_in_days = 0
#   tags                    = module.label.tags
#   # in cloud, randomness is known problem, as there is no real hardware and no true source for randomnesseverything virtual and shared by
#   # several VMsEven "secure random" source offered by OS has not enough entropy, just more obfuscationNot easy to exploit in CSRFStill
#   # tying token to user's identity by <shasum(user id+ server secret)> adds protection against that
#   description = "CSRF Secret. TECHGEN-6888."
#   lifecycle {
#     ignore_changes = [
#       id,
#       arn
#     ]
#   }
# }
# resource "aws_secretsmanager_secret" "db_be_un" {
#   name                    = "/${local.name_prefix}/db/service_be/username"
#   recovery_window_in_days = 0 // while we setting up infra - cancel AAWS "you can not delete and recreate secret unless x days passed"
#   tags                    = module.label.tags
#   description             = "Deprecated. ref TECHGEN-3503. BE service DB creds - username"
#   lifecycle {
#     ignore_changes = [
#       id,
#       arn
#     ]
#   }
# }
# resource "aws_secretsmanager_secret" "db_be_pw" {
#   name                    = "/${local.name_prefix}/db/service_be/password"
#   recovery_window_in_days = 0
#   tags                    = module.label.tags
#   description             = "Deprecated. ref TECHGEN-3503. BE service DB creds - pw"
#   lifecycle {
#     ignore_changes = [
#       id,
#       arn
#     ]
#   }
# }
# resource "aws_secretsmanager_secret" "to_remove_db_tmp_cred" {
#   name                    = "to_remove_db_creds"
#   recovery_window_in_days = 0
#   tags                    = module.label.tags
#   description             = "temp, for the sake of code to be refactored from https://github.com/phoenix/phoenix-lambda/blob/2ad52c37fa514c46b6842147820e1a1bf001d354/lambda-triggers/post-confirmation/post-confirmation-creating-user-lambda.js#L34"
#   lifecycle {
#     ignore_changes = [
#       id,
#       arn
#     ]
#   }
# }