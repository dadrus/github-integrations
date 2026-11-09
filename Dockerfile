# syntax = docker/dockerfile:experimental@sha256:600e5c62eedff338b3f7a0850beb7c05866e0ef27b2d2e8c02aa468e78496ff5
# Builder image to build the app
FROM golang:1.20.5-buster@sha256:eb3f9ac805435c1b2c965d63ce460988e1000058e1f67881324746362baf9572 as builder
LABEL maintainer=dadrus@gmx.de

ARG HOST_ARCH

ENV USER=heimdall
ENV UID=10001

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN useradd -l -s "/sbin/nologin" -M -U -r -u ${UID} ${USER}
RUN apt-get update && apt-get install --no-install-recommends -y xz-utils=5.2.4-1

# UPX is GPL
ADD https://github.com/upx/upx/releases/download/v3.96/upx-3.96-amd64_linux.tar.xz /usr/local
RUN xz -d -c /usr/local/upx-3.96-amd64_linux.tar.xz | \
    tar -xOf - upx-3.96-amd64_linux/upx > /bin/upx && \
    chmod a+x /bin/upx

ARG VERSION="unknown"

WORKDIR /go/src/github-integrations

COPY . .
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags="-buildid= -w -s -X main.Version=${VERSION}" \
    && if [ "$HOST_ARCH" = "arm64" ] ; then echo "skipping upx on ARM" ; else upx  github-integrations; fi

# The actual image of the app
FROM scratch
LABEL maintainer=dadrus@gmx.de

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /go/src/github-integrations/github-integrations /opt/github-integrations/github-integrations

WORKDIR /opt/github-integrations

USER ${USER}:${USER}

ENTRYPOINT ["/opt/github-integrations/github-integrations"]