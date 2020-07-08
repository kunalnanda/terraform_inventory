terraform {
    backend "s3" {
        bucket          = var.backend_bucket
        region          = var.aws_region
        key             = var.backend_key
        dynamodb_table  = var.backend_dyn_db
        encrypt         = true
    }
}