.PHONY: fmt docs validate test

fmt: ## Format all Terraform files
	terraform fmt -recursive

docs: ## Regenerate README inputs/outputs (terraform-docs)
	terraform-docs .

validate: ## terraform init (no backend) + validate
	terraform init -backend=false -upgrade
	terraform validate

test: ## Terratest — creates + destroys REAL resources; needs DASHTAG_API_TOKEN
	cd test && go test -v -timeout 30m

changelog: ## Add a changelog fragment (interactive)
	changie new

release-changelog: ## Assemble CHANGELOG.md for a release: make release-changelog VERSION=v0.1.0
	changie batch $(VERSION)
	changie merge
