.PHONY: help build test run package clean docker

help: ## Display this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build the application
	mvn clean compile

test: ## Run tests
	mvn test

run: ## Run the application locally
	mvn spring-boot:run

package: ## Package the application
	mvn clean package

clean: ## Clean build artifacts
	mvn clean

docker: ## Build Docker image
	docker build -t myapp:latest .

deploy: ## Deploy to Azure Container Apps (requires Azure CLI and environment)
	@echo "Make sure to configure your Azure Container App settings first"
	az containerapp up --name myapp --resource-group myapp-rg --location eastus --source .

logs: ## Tail Container App logs
	az containerapp logs tail --name myapp --resource-group myapp-rg --follow
