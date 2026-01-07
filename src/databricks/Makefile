.PHONY: help init validate deploy run destroy format lint test clean

help:
	@echo "Databricks Asset Bundle Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  init       - Initialize the Databricks bundle"
	@echo "  validate   - Validate the bundle configuration"
	@echo "  deploy     - Deploy the bundle to Databricks (requires -t target)"
	@echo "  run        - Run a job or pipeline (requires -t target and JOB_KEY)"
	@echo "  destroy    - Destroy the deployed bundle (requires -t target)"
	@echo "  format     - Format Python code with ruff"
	@echo "  lint       - Lint Python code with ruff"
	@echo "  test       - Run Python tests with pytest"
	@echo "  clean      - Clean up generated files"
	@echo ""
	@echo "Example usage:"
	@echo "  make validate"
	@echo "  make deploy TARGET=dev"
	@echo "  make run TARGET=dev JOB_KEY=my_job"

init:
	@echo "Initializing Databricks bundle..."
	databricks bundle init

validate:
	@echo "Validating bundle configuration..."
	databricks bundle validate

deploy:
ifndef TARGET
	$(error TARGET is not set. Usage: make deploy TARGET=dev)
endif
	@echo "Deploying bundle to $(TARGET)..."
	databricks bundle deploy -t $(TARGET)

run:
ifndef TARGET
	$(error TARGET is not set. Usage: make run TARGET=dev JOB_KEY=my_job)
endif
ifndef JOB_KEY
	$(error JOB_KEY is not set. Usage: make run TARGET=dev JOB_KEY=my_job)
endif
	@echo "Running job $(JOB_KEY) in $(TARGET)..."
	databricks bundle run -t $(TARGET) $(JOB_KEY)

destroy:
ifndef TARGET
	$(error TARGET is not set. Usage: make destroy TARGET=dev)
endif
	@echo "Destroying bundle from $(TARGET)..."
	databricks bundle destroy -t $(TARGET)

format:
	@echo "Formatting Python code..."
	ruff format .
	ruff check --fix .

lint:
	@echo "Linting Python code..."
	ruff check .

test:
	@echo "Running tests..."
	pytest

clean:
	@echo "Cleaning up..."
	find . -type d -name "__pycache__" -exec rm -rf {} + || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + || true
	find . -type f -name "*.pyc" -delete || true

# Install pre-commit hooks
git-hooks:
	@pre-commit install
