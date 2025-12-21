init:
ifndef ENV
	$(error ENV is not set)
endif
	@terraform init -backend-config=backends/backend-${ENV}.tfvars $(ARGS)

plan:
ifndef ENV
	$(error ENV is not set)
endif
	@GRAFANA_AUTH=$$(az account get-access-token \
	  --resource="ce34e7e5-485f-4d76-964f-b3d2b16d1e4f" \
		--query accessToken --output tsv) \
	  terraform plan -var-file="environments/${ENV}.tfvars" $(ARGS)

apply:
ifndef ENV
	$(error ENV is not set)
endif
	@GRAFANA_AUTH=$$(az account get-access-token \
	  --resource="ce34e7e5-485f-4d76-964f-b3d2b16d1e4f" \
		--query accessToken --output tsv) \
		terraform apply -var-file="environments/${ENV}.tfvars" $(ARGS)

destroy:
ifndef ENV
	$(error ENV is not set)
endif
	@GRAFANA_AUTH=$$(az account get-access-token \
	  --resource="ce34e7e5-485f-4d76-964f-b3d2b16d1e4f" \
		--query accessToken --output tsv) \
		terraform destroy -var-file="environments/${ENV}.tfvars" $(ARGS)

# install git pre commit hooks
git-hooks:
	@pre-commit install

tflintinit:
	@tflint --init

tflint:
	@tflint --recursive --config "$(shell pwd)/.tflint.hcl"

# generate docs for the root module
tfdocs:
	@terraform-docs . -c .terraform-docs-root.yml

format:
	@terraform fmt
