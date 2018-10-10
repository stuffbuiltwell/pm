# Variables.
BIN=$(shell go env GOPATH)/bin

## Development tools.
DEP=$(BIN)/dep

all: build

# Installing development tools.
$(DEP):
	curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Compilation targets.
SERVER=dist/pm
WEBAPP=dist/static/app.js

build: $(SERVER) $(WEBAPP)

$(SERVER): $(DEP) $(shell find . -type f -name *.go)
	dep check
	go build -o $@ ./cmd/pm

$(WEBAPP): $(shell find ./web/src -type f)
	cd web && \
		elm make --debug --output=../$@ src/Main.elm && \
		cp index.html ../dist/static/index.html

# Development tasks.
.PHONY: test
test:
	go test ./...

.PHONY: watch
watch:
	while true; do find . -type f | grep -vP '.git|elm-stuff|dist' | entr -d bash -c 'make && ./dist/pm -static=./dist/static'; done

.PHONY: clean
clean:
	rm -r ./dist/
