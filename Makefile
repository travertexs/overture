NAME=overture
WORKDIR=workdir
VERSION=$(shell git describe --tags || shell date -u)
GOBUILD=CGO_ENABLED=0 go build -ldflags "-s -w -X main.version=$(VERSION)" main/main.go

PLATFORM_LIST = \
	darwin-amd64 \
	darwin-amd64-v3 \
	darwin-arm64 \
	linux-386 \
	linux-amd64 \
	linux-amd64-v3 \
	linux-armv5 \
	linux-armv6 \
	linux-armv7 \
	linux-arm64 \
	linux-mips-softfloat \
	linux-mips-hardfloat \
	linux-mipsle-softfloat \
	linux-mipsle-hardfloat \
	linux-mips64 \
	linux-mips64le \
	linux-riscv64 \
	freebsd-386 \
	freebsd-amd64 \
	freebsd-amd64-v3 \
	windows-amd64 \
	windows-amd64-v3 \
	windows-arm64


.PHONY: create-sample build

create-sample:
	echo "127.0.0.1 localhost" > $(WORKDIR)/hosts_sample
	echo "127.0.0.9/32" > $(WORKDIR)/ip_network_primary_sample
	echo "127.0.0.10/32" > $(WORKDIR)/ip_network_alternative_sample
	echo "primary.example" > $(WORKDIR)/domain_primary_sample
	echo "alternative.example" > $(WORKDIR)/domain_alternative_sample
	echo "ttl.example 1000" > $(WORKDIR)/domain_ttl_sample

darwin-amd64:
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

darwin-amd64-v3:
	GOOS=darwin GOARCH=amd64 GOAMD64=v3 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

darwin-arm64:
	GOOS=darwin GOARCH=arm64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-386:
	GOOS=linux GOARCH=386 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-amd64:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-amd64-v3:
	GOOS=linux GOARCH=amd64 GOAMD64=v3 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-armv5:
	GOOS=linux GOARCH=arm GOARM=5 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-armv6:
	GOOS=linux GOARCH=arm GOARM=6 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-armv7:
	GOOS=linux GOARCH=arm GOARM=7 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-arm64:
	GOOS=linux GOARCH=arm64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-mips-softfloat:
	GOOS=linux GOARCH=mips GOMIPS=softfloat $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-mips-hardfloat:
	GOOS=linux GOARCH=mips GOMIPS=hardfloat $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-mipsle-softfloat:
	GOOS=linux GOARCH=mipsle GOMIPS=softfloat $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-mipsle-hardfloat:
	GOOS=linux GOARCH=mipsle GOMIPS=hardfloat $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-mips64:
	GOOS=linux GOARCH=mips64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-mips64le:
	GOOS=linux GOARCH=mips64le $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

linux-riscv64:
	GOOS=linux GOARCH=riscv64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

freebsd-386:
	GOOS=freebsd GOARCH=386 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

freebsd-amd64:
	GOOS=freebsd GOARCH=amd64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

freebsd-amd64-v3:
	GOOS=freebsd GOARCH=amd64 GOAMD64=v3 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

freebsd-arm64:
	GOOS=freebsd GOARCH=arm64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

windows-amd64:
	GOOS=windows GOARCH=amd64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

windows-amd64-v3:
	GOOS=windows GOARCH=amd64 GOAMD64=v3 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

windows-arm64:
	GOOS=windows GOARCH=arm64 $(GOBUILD) -o $(WORKDIR)/$(NAME)-$@ \
	zip $(NAME)-$@.zip $(WORKDIR)/$(NAME)-$@ $(WORKDIR)/hosts_sample $(WORKDIR)/ip_network_primary_sample $(WORKDIR)/ip_network_alternative_sample $(WORKDIR)/domain_primary_sample $(WORKDIR)/domain_alternative_sample $(WORKDIR)/domain_ttl_sample

build:
	for platform in $(PLATFORM_LIST); do \
		make $$platform; \
	done
