# Test environment values
# Usage: terraform plan -var-file="test.tfvars"
#        terraform apply -var-file="test.tfvars"

test_ami_id          = "ami-03caad32a158f72db"
test_instance_type   = "t2.micro"
env                  = "test"
vpc_cidr             = "10.0.0.0/16"
public_subnet1_cidr  = "10.0.1.0/24"
availability_zone_2a = "us-west-2a"
