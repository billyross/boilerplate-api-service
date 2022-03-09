# Boilerplate API Service

## Introduction

An example project designed to flesh out boilerplate, project structure and CI/CD process. Notable features include:

- Service implementation using the [Go language](https://go.dev/) and the [Echo Web Framework](https://echo.labstack.com/)
- [Contract-First](https://openpracticelibrary.com/practice/contract-first-development/) using [OpenAPI](https://swagger.io/docs/specification/about/)
- Types, server and client code generation with [oapi-codegen](https://github.com/deepmap/oapi-codegen)
- Simple deployment via a single binary or lightweight [Containerfile](https://docs.docker.com/engine/reference/builder/)

## Getting Started

Ensure you have the following installed and correctly setup before proceeding to build the project:

1. `Go` Development Tools
   - Available for all platforms [here](https://go.dev/dl/)
2. `GNU Make`
   - Available in all GNU/Linux package managers (i.e. `dnf install make` or `apt-get install make`)
   - Available in Windows via [Chocolatey](https://chocolatey.org/install) (i.e. `choco install make`)

Optional Extras:

1. OpenAPI Code Generator (aka `oapi-codegen` for regenerating any OpenAPI changes)
   - Available via `go install github.com/deepmap/oapi-codegen/cmd/oapi-codegen@latest`
2. `golangci-lint` (for running linting tasks)
   - Available for all platforms [here](https://golangci-lint.run/usage/install/)
3. `Docker` (or preferably `Podman` for building the container image)
   - Available for Windows [here](https://www.docker.com/get-started)
   - Podman is only available for GNU/Linux [here](https://podman.io/getting-started/installation). Don't forget to enable `docker` [aliasing](https://podman.io/whatis.html)

## Build and Test

```
# Run the test suite
$ make test

# Build the service binary and run it
$ make build
$ ./bin/boilerplate[.exe]

OR

# Just start the service
$ make run
```

## Project Structure

    ├── cmd                          # Go conventional folder for entrypoints
    │   └── boilerplate              # Corresponds to the compiled binary name
    │       └── main.go              # Entry point for the application
    │
    ├── internal                     # Go conventional folder for private code
    │   └── service                  # Contains service implementation code
    │       ├── boilerplate.go       # Implementation of the API interface
    │       └── boilerplate_test.go  # Unit tests for the service implementation
    │
    ├── pkg                          # Go conventional folder for shared code
    │   └── api                      # Contains generated code from OpenAPI
    │       ├── client.go            # Generated OpenAPI client
    │       ├── types.go             # Generated types from the spec's model schema
    │       └── server.go            # Generated HTTP server interface from the spec
    │
    ├── go.mod                       # Go modules dependencies
    ├── go.sum                       # Go modules checksums
    ├── Makefile                     # Make targets defining project tasks to run
    ├── openapi.yaml                 # OpenAPI definitions for the API
    ├── Containerfile                # aka Dockerfile for building a container image
    └── README.md                    # What you are looking at

> **Do not attempt to add or edit any files in the project's `pkg/api` directory**. Files in this directory are automatically generated and any changes will be wiped anytime the OpenAPI definitions are updated.

## Available Commands

Targets for various functions can be listed simply by running `make`. These tasks include:

- `build` - Build the project and put the output binary in `bin/`
- `test` - Run the project's test suite
- `lint` - Run linting and static analysis tools (`golangci-lint`)
- `clean` - Delete build related files
- `run` - Start the service
- `build-image` - Build a container image using the project `Containerfile`
- `run-container` - Run the service from a previously built image
- `generate-oapi` - Regenerate server/client code from OpenAPI definitions
- `help` - Show available `make` targets (i.e. this list)
