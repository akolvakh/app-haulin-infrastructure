# S3 Secure Bucket
module "codepipeline_bucket" {
  source = "../../../generic-modules/s3/secure_bucket"

  bucket = substr("${local.name_prefix}-artifacts-${random_id.db.dec}", 0, 63)

}