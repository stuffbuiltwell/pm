# Variables.
BIN=$(shell go env GOPATH)/bin

## Development tools.
DEP=$(BIN)/dep

all: build

# Installing development tools.
$(DEP):
	curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Compilation targets.
build: $(BIN)/pm

$(BIN)/pm: $(DEP)
	dep check
	go install ./cmd/pm

# Development tasks.
.PHONY: test
test:
	go test ./...
