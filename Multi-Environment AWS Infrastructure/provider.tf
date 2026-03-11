# ============================================================
# PROVIDERS
# ============================================================
# Uses AWS CLI named profiles (~/.aws/credentials)
# Profile "dev"  → us-east-1  (dev environment)
# Profile "test" → us-west-2  (test environment)
# ============================================================

provider "aws" {
  alias   = "devenv"
  region  = "us-east-1"
  profile = "dev"
}

provider "aws" {
  alias   = "testenv"
  region  = "us-west-2"
  profile = "test"
}
