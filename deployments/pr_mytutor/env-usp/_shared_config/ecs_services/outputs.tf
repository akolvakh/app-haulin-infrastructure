output "service_names" {
  # value       = ["be", "vpn_proxy"]
  # api_gateway
  # value       = ["be", "user", "import", "message-bus", "program-management", "lesson-management", "qa-irina", "qa-ihor", "qa-hanna", "api-gateway", "payment"]
  
  value = {
    dev           = ["be", "user", "import", "message-bus", "program-management", "lesson-management", "qa-irina", "qa-ihor", "qa-hanna", "api-gateway", "payment", "tutor-onboarding-application", "interview"]
    usp-dev       = ["user", "import", "message-bus", "program-management", "lesson-management", "api-gateway", "payment", "tutor-onboarding-application", "interview"]
    qa            = ["user", "import", "message-bus", "program-management", "lesson-management", "qa-irina", "qa-ihor", "qa-hanna", "api-gateway", "payment", "tutor-onboarding-application", "interview"]
    staging       = ["user", "import", "message-bus", "program-management", "lesson-management", "api-gateway", "payment", "tutor-onboarding-application", "interview"]
    prod          = ["user", "import", "message-bus", "program-management", "lesson-management", "api-gateway", "payment", "tutor-onboarding-application", "interview"]
    production    = ["user", "import", "message-bus", "program-management", "lesson-management", "api-gateway", "payment", "tutor-onboarding-application", "interview"]
  }
  
  description = "ECS services to prepare infra for"
}

output "firebase_android_package_name" {
  value = {
    staging = "com.phoenix.staging"
    dev     = "com.phoenix.dev"
    prod    = "com.phoenix.app"
    qa      = "com.phoenix.qa"
  }
  description = "Firebase values for Android"
}

output "firebase_ios_bundle_id" {
  value = {
    staging = "com.phoenix.staging"
    dev     = "com.phoenix.dev"
    prod    = "com.phoenix.application"
    qa      = "com.phoenix.qa"
  }
  description = "Firebase values for IOS"
}
