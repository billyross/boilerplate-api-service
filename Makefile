SHELL        := /bin/sh
APP_NAME     := boilerplate

.PHONY: all build test lint clean run help

all: help

build: ## Build the project and put the output binary in bin/
	@go build -o bin/$(APP_NAME) -v cmd/$(APP_NAME)/main.go

test: ## Run the project's test suite
	@go test -v ./...

lint: ## Run linting and static analysis tools (golangci-lint)
	@golangci-lint run

clean: ## Delete build related files
	@rm -rf bin

run: ## Start the service
	@go run cmd/$(APP_NAME)/main.go

build-image: ## Build a container image using the project Containerfile
	@docker build -t $(APP_NAME) .

run-container: ## Compile and run the service in a container
	@docker run -t -i -p 8080:8080 $(APP_NAME)

generate-oapi: ## Regenerate server/client code from OpenAPI definitions
	@rm -rf pkg/api/*
	@oapi-codegen -generate types -package api openapi.yaml > pkg/api/types.go
	@oapi-codegen -generate client -package api openapi.yaml > pkg/api/client.go
	@oapi-codegen -generate server,spec -package api openapi.yaml > pkg/api/server.go

help: ## Show available make targets
	@echo 'Usage:'
	@echo '  make <target>'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    %-20s%s\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  %s\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)
