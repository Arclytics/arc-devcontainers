.PHONY: help init validate deploy run destroy format lint test clean git-hooks streamlit

help:
	@echo "Databricks Streamlit App Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  init       - Initialize the Databricks bundle"
	@echo "  validate   - Validate the bundle configuration"
	@echo "  deploy     - Deploy the bundle to Databricks (requires TARGET)"
	@echo "  run        - Run a job or app (requires TARGET and JOB_KEY)"
	@echo "  destroy    - Destroy the deployed bundle (requires TARGET)"
	@echo "  streamlit  - Run Streamlit app locally (requires APP_FILE)"
	@echo "  format     - Format Python code with ruff"
	@echo "  lint       - Lint Python code with ruff"
	@echo "  test       - Run Python tests with pytest"
	@echo "  clean      - Clean up generated files"
	@echo ""
	@echo "Example usage:"
	@echo "  make validate"
	@echo "  make deploy TARGET=dev"
	@echo "  make streamlit APP_FILE=app.py"
	@echo "  make run TARGET=dev JOB_KEY=my_app"

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
	$(error TARGET is not set. Usage: make run TARGET=dev JOB_KEY=my_app)
endif
ifndef JOB_KEY
	$(error JOB_KEY is not set. Usage: make run TARGET=dev JOB_KEY=my_app)
endif
	@echo "Running app $(JOB_KEY) in $(TARGET)..."
	databricks bundle run -t $(TARGET) $(JOB_KEY)

destroy:
ifndef TARGET
	$(error TARGET is not set. Usage: make destroy TARGET=dev)
endif
	@echo "Destroying bundle from $(TARGET)..."
	databricks bundle destroy -t $(TARGET)

streamlit:
ifndef APP_FILE
	$(error APP_FILE is not set. Usage: make streamlit APP_FILE=app.py)
endif
	@echo "Running Streamlit app: $(APP_FILE)..."
	streamlit run $(APP_FILE)

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
