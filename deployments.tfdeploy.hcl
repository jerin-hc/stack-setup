deployment "production" {
  inputs = {
    bucket_name = "prod"
    environment = "prod"
  }
}

deployment "development" {
  inputs = {
    bucket_name = "dev"
    environment = "dev"
  }
}