#-------------------------------------------------------------------------------
# 2.gitlab
#-------------------------------------------------------------------------------
# TODO
    -
    -
# NOTES
    -
#
#-------------------------------------------------------------------------------
# 10.vpc
#-------------------------------------------------------------------------------
# TODO
    -
    -
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# VPC layer
    - lowest one
    - VPN in two AZs for HA.
    - Every AZ has subnets:
    - public: public loadabalancers, NAT gateways. Consider reduce NAT gateways to 1 outside of prod, to reduce cost
    - private: data. Host  DB,  Cache
    - private: services. Host all Contaienrs there
    - private: private lodabaalances for service -> service interfaction as also for background processes --> service interaction
    - ergress: allowed in full, to narrow/reduce to AWS services via service end points
    - note - subnets in AWS are meaningful only for manageability/keeping seprate "things" separate. There is no security or performance aspect, given how virtualized AWS network works
# Ref
    - Infra layers diagram https://miro.com/app/board/o9J_lpkHmqI=/
    - AWS deployment diagram https://miro.com/app/board/o9J_lEn1cL0=/
#
#-------------------------------------------------------------------------------
# 15.dns
#-------------------------------------------------------------------------------
# TODO
    -
    -
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# DNS layer
    - stub for now, to be implementd on Cloudflare (or Route53)
    - mostly defines internet visible DNS name of the APP, base for URLs construction
    - as also private DNS visible name of Admin entry point
#
#-------------------------------------------------------------------------------
# 17.acm_private_certificate
#-------------------------------------------------------------------------------
# TODO
    -
    -
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Private CA authority
    - certificate for TLS inside VPC.
    - every region in the ajuma  app to be selfcontianed and selfsufficient, never havae dependnecy on another region
# DOCS
      register DNS name in Route53 (1.route53)
      create organization -> user per environment in AWS WorkMail (5.workmail)
      add credentials to 1Password
      run make apply to this layer, get email approval email -> approve this certificate OR add records to route53
      admin@env.dns_name (admin@prod.ajuma.link)
      
      Your load balancer uses a Secure Socket Layer (SSL) negotiation configuration, known as a security policy, to negotiate SSL connections with clients.
      ELBSecurityPolicy-FS-1-2-Res-2020-10
    
      -route53
      -15.dns
      -17.acm_prvate_certificate
      -20.static_ips
      -30.alb
      -100.private_dns
#
#-------------------------------------------------------------------------------
# 20.parameters
#-------------------------------------------------------------------------------
# TODO
    - paramters that require APP service(s) restart to pickup change should be marked as such
    -
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Parameters layer
    - parameters affecting APP beahvior, can be amended runtime
    - manageable by DEvOps team using terraform/AWS Control Panel
#
#-------------------------------------------------------------------------------
# 20.secrets
#-------------------------------------------------------------------------------
# TODO
    - automate rotation
    - why not use terraform remote state to pickup secrets key names in code leveraging those? Instead of referencing those from code by naming convention?
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Secrets layer
    - All secrets - in Secrets vault (aws secrets manager).
    - key name only - values have to be set manuallyfor now, by automated rotation eventually)
    - Pls have description for every secret, it's rotatino policy in Wiki linked
#
#-------------------------------------------------------------------------------
# 20.sg
#-------------------------------------------------------------------------------
# TODO
    - narrow, ideally remove egress
    -
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Security groups layer
    - Security Groups are very security sensitive - we want have single place in sources where those defined. For the sake of code audit
    - Every network exposed resource must have a security group attached
    - Never use ip ranges in security groups unelss have to. Referencing to oher security groups by ID, instead of IP range is recommended
    - every service has individual security group
    - DB,Cache,Autodeploy scrupting for DB schema management, Public LB, Private LB (only local VPC visible), Admin LB (admin entry point, to be security hardedend vs regular APP)
#
#-------------------------------------------------------------------------------
# 20.static_ips
#-------------------------------------------------------------------------------
# TODO
    -
    -
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Static IPs
    - Split VPN for non prod environments isolation and for securing access to prod admin
    - static internet routable IPs for VPN oriented entry point into environment
    - to ensure those IPs never accidently busted while redeploying ifnra - we keep state for them in seprated folder
# Question
    - WHY lifecycle.prevent_destroy=true is not enough?? Per experience it is not (terraform 1.0.10)
#
#-------------------------------------------------------------------------------
# 25.bastion
#-------------------------------------------------------------------------------
# TODO
    -
    -
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# VPC layer
    - lowest one
    - VPN in two AZs for HA.
    - Every AZ has subnets:
    - public: public loadabalancers, NAT gateways. Consider reduce NAT gateways to 1 outside of prod, to reduce cost
    - private: data. Host  DB,  Cache
    - private: services. Host all Contaienrs there
    - private: private lodabaalances for service -> service interfaction as also for background processes --> service interaction
    - ergress: allowed in full, to narrow/reduce to AWS services via service end points
    - note - subnets in AWS are meaningful only for manageability/keeping seprate "things" separate. There is no security or performance aspect, given how virtualized AWS network works
# Ref
    - Infra layers diagram https://miro.com/app/board/o9J_lpkHmqI=/
    - AWS deployment diagram https://miro.com/app/board/o9J_lEn1cL0=/
#
#-------------------------------------------------------------------------------
# 30.alb
#-------------------------------------------------------------------------------
# TODO
    -
    -
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Load balancers layer
    - private LB - for communicating microservice->microservice, background job->microservice
    - public LB - APP entry point, currentyl exposed to AppSync, can replace AppSync eventually
    - admin lb - VPNed only access to admin app
    - NLB - provides static IP to access public ALB from ajuma split-vpn. //ref https://ajuma.atlassian.net/browse/TECHGEN-2683
# KNOWN DEFECTS
    - Static EIP for VPN - should be, but are not preserved when run terraform apply!
    - export them from tf state first, aas workaround.
    - ref https://ajuma.atlassian.net/browse/TECHGEN-5813
# Workaround  Example
    - ` terraform state rm <EIP resource ID> `
    - ` terraform import <EIP Allocation ID in AWS> `
    - ` terraform import aws_eip.nlb[0] eipalloc-00a10e96 `
#
#-------------------------------------------------------------------------------
# 30.db
#-------------------------------------------------------------------------------
# TODO
    - cross region repl for HA
    - per service data protection
    - can we ditch credentials managed by us and switch to IAM roles/AWS managed credentials
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# DB layer
    - Aurora RDS, Postgress
    - two AZs, single master(Aurora serverless v1 limitatation) relication out of box as provided by AWS
# Implementation details
    - for cross account backups - RDS has to use custemr manged keey, accessible to Backup Acct AWs Backup service as also to local acct AWS Backup Service
    - to have cross accoutn backups, run terraform in deployments/z-control with admin permissions for Z-Control account, to enable crossa ccount backup policy
    - then run terraform in deployments/backup/backup with Admin permissons for backup account to setup centralized backup vault
    - then run in current account, where RDS being created is source for backup
#
#-------------------------------------------------------------------------------
# 32.service_discovery
#-------------------------------------------------------------------------------
# TODO
    -
    -
# NOTES
    -
#
#-------------------------------------------------------------------------------
# 33.lambda_cognito_post_signup
#-------------------------------------------------------------------------------
# TODO
    - For Admin portal, will be simpler just place admin ui and server side behind same one vpn\_proxy and leverage nginx caching
    -
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Intention
    - For web apps/Admin Portal, we want cache data in HTTP.
    - Have to either do fragile process of setting attributes per S3 "file"/key, or put Lambda at clouudfront. AWS does not give us better option.
#
#-------------------------------------------------------------------------------
# 33.lambda_cognito_pre_signup
#-------------------------------------------------------------------------------
# TODO
    - For Admin portal, will be simpler just place admin ui and server side behind same one vpn\_proxy and leverage nginx caching
    -
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
    - 
# Intention
    - For web apps/Admin Portal, we want cache data in HTTP.
    - Have to either do fragile process of setting attributes per S3 "file"/key, or put Lambda at clouudfront. AWS does not give us better option.
#
#-------------------------------------------------------------------------------
# 35.cognito
#-------------------------------------------------------------------------------
# TODO
    - IP whitelist Cognito in DEV/STage, close from world
    - metrics
    - logging  (for now, CloudTrail for auth atempts, and SNS log for texts sent)
    - suspicious behavior detection, Soft stop(Captcha), Hard Stop (Block)
    - export user records from Cognito blakcbox storage for the sake of potential  migratino from AWS
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Cognito
    - AWS provided authenthication service
    - two seprated instances, "regular" for APP and "locked down" for Admin portal
    - Admin portal SSO with GSuite, WIP.
    - Privileged ajuma admin can crate user ercords for Admin portal in Cognito
    - Admin portals entitlements/roles assignment - WIP
    - APP - user self registers, username=mangled email
    - APP - custom pre signup and pre auth lambdas for policy enforcement
    - APP - depends on integration Congito+SNS for  mobile phone verificatin by texts  on singup/password reset
    - APP - depends on integration Congito+SES for  email verificatin by texts on signup/password reset
# Impl notes
    - deploy has manual steps - https://ajuma.atlassian.net/wiki/spaces/DOCUMENTAT/pages/470024498/Infrastructure+deployment+runbooks
#
#-------------------------------------------------------------------------------
# 40.ecs
#-------------------------------------------------------------------------------
# TODO
    seprate repo per service reduces prod availability, but how much?
    ref https://aws.amazon.com/ecr/sla/
    AWS promises 99.9%
    we going ot have ~10 services, 10 repos. HA = 0.999^10=0.9900
    Shuld be ok for first version.
    @TBD - data retention policy 
    -
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# ECS
    - dockerized microservices deployment  
    - each microservice has individual SecurityGroup, TaskRole(s),ExecutionRole
    - all SecurityGroup managed  in 20.sg
    - TaskRole(s),ExecutionRole - in this TF module
    - picked up by CI/CD when deploy
    - FARGATE only, no messing up with EC2 instances
    - Spot Fargate allowed, can be turned on per microservice, in layers up/CI/CD level
#
#-------------------------------------------------------------------------------
# 56.s3
#-------------------------------------------------------------------------------
# TODO
    - Automate dployment of those
    - keep deploy backward compatible/preserve old versions side by side with new, as we can not update Mobile clients instanteneously
    - for the sake of white label, dont tie assets deploy to APP deploy, let it happen any time in Prod
    - for the sake of testing, have assets immutable packages made once, and deployable anywhere
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Static UI assets for Mobile APP
    - world open in PROD. Nice to have to close them by VPN in Dev/Stage
#
#-------------------------------------------------------------------------------
# 100.private_dns
#-------------------------------------------------------------------------------
# TODO
    -
    -
# Troubleshooting
# Design intro
    - "microservice style" infra as code layout
    - terraform state separated into "layers", exposing outside "interfaces" via terraform remote state
    - to simplify dependencies tracking, layers down know nothing about layers on top.
    - modification of a layer should never require modifications of layer(s) down
# Private DNS for VPN clients
    - WIP
    - What it does in ajuma-app, should not it be inside VPN account/VPC?
#
#-------------------------------------------------------------------------------
# 1001.ecs_service_be
#-------------------------------------------------------------------------------
# TODO
    - refactor into reusable module - too much shameful copy paste, inherited aas shortcut
    -
# Troubleshooting
# Cloud resources for the specific REST service
    - should not be created when depoy ifnra a code, but only by CD
    - only as manual fallback, if CD failed, do usual make plan/make apply here
# How To run manually fallbback service deploy
    - precondition
    -  service image(s) exists in docker registry and match naming convention "${docker\_registry\_url}/${service\_2\_deploy}:${version\_2\_ceploy}",
    - in  shell
    - ` make <env>-env, make init `
    - ` export TF_VAR_service_name=<service to deploy> `
    - ` export TF_VAR_service_version=<version 2 deploy> `
    - ` make apply `
    -  
# INPUT to be set by automated CI/CD pipeline
    -  serviceName - what service to deploy?
    -  serviceVersino - ? What version of build arifacts/docker images?
    -  targt environment
    -  target aws region
# Autoscaling configuration
    -  min/max/desired # of  service instances, DIFFERENCE PER ENV
    - scaling policy
    -
# Resource limits
    - CPU/RAM/IO caps. no difference per env. We do horizontal scaling/add more processes instead of adding more CPU/RAM to single process
# Dependencies
    - provided by TF IaC layers below:  Subnets intended  for services, SecGroups,TaskRole,TaskExecRole, Load Balancer associated target group(s)
# Load balancing configuration
    - case 1
    - a service exposed outside of VPC (via public APP ALB)  // typical microservice will be. Shall we prx Auth/Entl check to API gateway and proxy throigh that?
    - case 2
    - a service exposed outside of VPC (via  Admin ALB )
    - should be single one? As Admin interface we want keep simple. Ideally a simple web app, no services. It is control plane vs data plane.
    - case 3
    - a servoce exposed to other services in current VPC only. As is security sensitive. (Via Private ALB)
    - case 4
    - a servoce is not security sensitive still exposed to other services in current VPC (via private ALB) and to world (via public ALB).  
#
