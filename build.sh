#!/usr/bin/env bash

# copied from
# https://github.com/lework/skopeo-binary/blob/master/.github/workflows/build.yml

mkdir -p ./bin

# golang:1.19.2-alpine3.16
docker pull golang:1.19.2-alpine3.16

docker run --rm -t -v $PWD:/build golang:1.19.2-alpine3.16 sh -c "apk update && apk add gpgme btrfs-progs-dev llvm13-dev gcc musl-dev && cd /build && CGO_ENABLE=0 GO111MODULE=on GOOS=linux GOARCH=amd64 go build -mod=vendor '-buildmode=pie' -ldflags '-extldflags -static' -gcflags '' -tags 'exclude_graphdriver_devicemapper exclude_graphdriver_btrfs containers_image_openpgp' -o ./bin/skopeo-linux-amd64 ./cmd/skopeo && md5sum ./bin/skopeo-linux-amd64 > ./bin/skopeo-linux-amd64.md5 && sha256sum ./bin/skopeo-linux-amd64 > ./bin/skopeo-linux-amd64.sha256"

docker run --rm -t -v $PWD:/build golang:1.19.2-alpine3.16 sh -c "apk update && apk add gpgme btrfs-progs-dev llvm13-dev gcc musl-dev && cd /build && CGO_ENABLE=0 GO111MODULE=on GOOS=linux GOARCH=arm64 go build -mod=vendor '-buildmode=pie' -ldflags '-extldflags -static' -gcflags '' -tags 'exclude_graphdriver_devicemapper exclude_graphdriver_btrfs containers_image_openpgp' -o ./bin/skopeo-linux-arm64 ./cmd/skopeo && md5sum ./bin/skopeo-linux-arm64 > ./bin/skopeo-linux-arm64.md5 && sha256sum ./bin/skopeo-linux-arm64 > ./bin/skopeo-linux-arm64.sha256"

ls -al bin/
