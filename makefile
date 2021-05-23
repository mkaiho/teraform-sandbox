.PHONY: init plan apply destroy check

aws-configure:
	@docker-compose run --rm terraform-cli aws configure

init:
	@docker-compose run --rm terraform-cli terraform init

plan:
	@docker-compose run --rm terraform-cli terraform plan

apply:
	@docker-compose run --rm terraform-cli terraform apply

destroy:
	@docker-compose run --rm terraform-cli terraform destroy
