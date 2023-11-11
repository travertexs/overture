GOBUILD=go build -ldflags "-s -w -X main.version=$$(git describe --tags)" -o overture-$$GOARCH main/main.go

GO_OS_ARCH_LIST = \
	darwin-amd64 \
	darwin-amd64-v3 \
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
	linux-loong64 \
	freebsd-386 \
	freebsd-amd64 \
	freebsd-amd64-v3 \
	windows-386 \
	windows-amd64 \
	windows-amd64-v3 \
	windows-arm64 \
	windows-armv7

GO_IOS_ARCH_LIST = \
	darwin-arm
	darwin-arm64 \

GO_ANDROID_ARCH_LIST = \
	android-arm-arm-linux-androideabi \
	android-arm64-aarch64-linux-android \
	android-386-i686-linux-android \
	android-amd64-x86_64-linux-android

.PHONY: build build-ios build-android create-sample

build:
	for arch in $(GO_OS_ARCH_LIST); do \
		make go_build_desktop GOARCH=$$arch; \
	done

build-ios:
	for arch in $(GO_IOS_ARCH_LIST); do \
		make go_build_ios GOARCH=$$arch; \
	done

build-android:
	for arch in $(GO_ANDROID_ARCH_LIST); do \
		make go_build_android GOARCH=$$arch; \
	done

create-sample:
	echo "127.0.0.1 localhost" > ./hosts_sample
	echo "127.0.0.9/32" > ./ip_network_primary_sample
	echo "127.0.0.10/32" > ./ip_network_alternative_sample
	echo "primary.example" > ./domain_primary_sample
	echo "alternative.example" > ./domain_alternative_sample
	echo "ttl.example 1000" > ./domain_ttl_sample

go_build_desktop:
	GOOS=$$(echo $$GOARCH | cut -d'_' -f1) \
	GOARCH=$$(echo $$GOARCH | cut -d'_' -f2) \
	CGO_ENABLED=0 $(GOBUILD)
	zip overture-$$GOARCH.zip overture-$$GOARCH hosts_sample ip_network_primary_sample ip_network_alternative_sample domain_primary_sample domain_alternative_sample domain_ttl_sample

go_build_ios:
	CC=$$(go env GOROOT)/misc/ios/clangwrap.sh \
	GOOS=$$(echo $$GOARCH | cut -d'_' -f1) \
	GOARCH=$$(echo $$GOARCH | cut -d'_' -f2) \
	CGO_ENABLED=1 $(GOBUILD)
	zip overture-$$GOARCH.zip overture-$$GOARCH hosts_sample ip_network_primary_sample ip_network_alternative_sample domain_primary_sample domain_alternative_sample domain_ttl_sample

go_build_android:
	CC=$$ANDROID_NDK_ROOT/bin/$$(echo $$GOARCH | cut -d'_' -f3)/bin/clang \
	GOOS=$$(echo $$GOARCH | cut -d'_' -f1) \
	GOARCH=$$(echo $$GOARCH | cut -d'_' -f2) \
	CGO_ENABLED=1 $(GOBUILD)
	zip overture-$$GOARCH.zip overture-$$GOARCH hosts_sample ip_network_primary_sample ip_network_alternative_sample domain_primary_sample domain_alternative_sample domain_ttl_sample
