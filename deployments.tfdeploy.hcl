deployment "west-coast" {
  inputs = {
    bucket_name     = "prod"
  }
}
 
deployment "east-coast" {
  inputs = {
    bucket_name     = "dev"
  }
}