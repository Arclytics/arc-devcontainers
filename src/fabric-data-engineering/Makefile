.PHONY: help format lint test clean git-hooks

help:
	@echo "Microsoft Fabric Data Engineering Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  format     - Format Python code with ruff"
	@echo "  lint       - Lint Python code with ruff"
	@echo "  test       - Run Python tests with pytest"
	@echo "  clean      - Clean up generated files"
	@echo "  git-hooks  - Install pre-commit hooks"
	@echo ""
	@echo "Example usage:"
	@echo "  make format"
	@echo "  make lint"
	@echo "  make test"

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
