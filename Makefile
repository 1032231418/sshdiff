# Go params
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
GOFMT=$(GOCMD) fmt
LDFLAGS='-s -w -extldflags "-static"'	# Build as static binary & remove symbol info.
BINARY_NAME=sshdiff
BINARY_WIN_SUFFIX=-win.exe

all: build
build:
	CGO_ENABLED=0 $(GOBUILD) -o $(BINARY_NAME) --ldflags $(LDFLAGS) -i -v
build-windows:
	GOOS=windows CGO_ENABLED=0 $(GOBUILD) -o $(BINARY_NAME)$(BINARY_WIN_SUFFIX) --ldflags $(LDFLAGS) -i -v
test:
	$(GOTEST) -v ./...
fmt:
	$(GOFMT) ./...
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME) $(BINARY_NAME)$(BINARY_WIN_SUFFIX)
run:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...
	./$(BINARY_NAME)
