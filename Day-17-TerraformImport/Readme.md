/*

Command Used

1. Remove existing details of aws EC2 Instance from Current TF State File

terraform state rm aws_instance.appserver


2. Import an EC2 instance of bucket details into TF Statefile which are created manually on AWS 
    (Make sure you note the instance ID of particular service of AWS and define below)

terraform import aws_instance.appserver i-010de790d7f35e725

