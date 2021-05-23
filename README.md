# teraform-sandbox

## prerequisite

- must be installed the followings on your local machine.

  - make

  - ssh

  - Docker

  - Docker Compose

- must create your aws account.

- must create your IAM User and memorize following credentials.

  - AWS Access Key ID

  - AWS Secret Access Key

- attach the following policy to your IAM User.

  - AmazonEC2FullAccess

  - AmazonVPCFullAccess

## source clone

```.sh
git clone git@github.com:mkaiho/terraform-sandbox.git
cd terraform-sandbox
```

## generate ssh key to log in ec2 created by terraform

```.sh
ssh-keygen -t rsa -f ./docker/workspace/.ssh/id_rsa
```

## configure aws

```.sh
# type your credentials
make aws-configure
```

## create or change resources using terraform

```.sh
# initialize terraform
make init
# show details about resources operations 
make plan
# execute create, change or delete operations to resources
# need to type "yes"
make apply
```

## destroy resources

```.sh
# initialize terraform
# CAUTION: Make sure type "yes" and check being deleted instance!
make destroy
```
