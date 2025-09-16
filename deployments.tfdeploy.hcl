deployment "production-test" {
  inputs = {
    regions        = ["eu-north-1"]
    role_arn       = "arn:aws:iam::246412344879:role/jerin-full-access-role"
    identity_token = identity_token.aws.jwt
    default_tags   = { stacks-preview-example = "lambda-component-expansion-stack" }
    bucket_name    = "prod"
    environment    = "prod"
  }
}

deployment "development-test" {
  inputs = {
    regions        = ["eu-north-1"]
    role_arn       = "arn:aws:iam::246412344879:role/jerin-full-access-role"
    identity_token = identity_token.aws.jwt
    default_tags   = { stacks-preview-example = "lambda-component-expansion-stack" }
    bucket_name    = "dev"
    environment    = "dev"
  }
}

identity_token "aws" {
  audience = ["aws.workload.identity"]
}