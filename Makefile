# Same commands locally and in CI. Written for GNU make 3.81 (macOS default).
SHELL := /bin/bash
.DEFAULT_GOAL := help

# Modules are validated through their example callers.
TF_DIRS := $(sort $(dir $(shell find examples -name '*.tf' -not -path '*/.terraform/*')))

.PHONY: help fmt fmt-check validate lint scan check

help: ## list targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "} {printf "  %-10s %s\n", $$1, $$2}'

fmt: ## terraform fmt -recursive
	terraform fmt -recursive

fmt-check: ## fail if a .tf file is not formatted
	terraform fmt -recursive -check -diff

validate: ## terraform validate for every example
	@set -e; for d in $(TF_DIRS); do \
	  echo "terraform validate $$d"; \
	  terraform -chdir=$$d init -backend=false -input=false >/dev/null; \
	  terraform -chdir=$$d validate; \
	done

lint: ## tflint (rules in .tflint.hcl)
	tflint --init --config "$(CURDIR)/.tflint.hcl"
	tflint --recursive --config "$(CURDIR)/.tflint.hcl"

scan: ## trivy config + gitleaks
	trivy config --exit-code 1 --severity HIGH,CRITICAL --skip-dirs '**/.terraform' --quiet .
	gitleaks git --no-banner --redact .

check: fmt-check validate lint scan ## run before finishing (same as CI)
