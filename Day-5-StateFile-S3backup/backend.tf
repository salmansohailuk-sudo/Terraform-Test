  #provider = aws.uatenv
terraform {
  #provider = aws.uatenv
  backend "s3" {
    #provider = aws.uatenv
    bucket = "terrafromstatebackup"
    key    = "terraform.tfstate"
    profile = "uat"
        region = "us-east-1"
  }
}