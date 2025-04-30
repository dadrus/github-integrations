# syntax = docker/dockerfile:experimental
# Builder image to build the app
FROM --platform=$BUILDPLATFORM golang:1.24.2-bookworm@sha256:79390b5e5af9ee6e7b1173ee3eac7fadf6751a545297672916b59bfa0ecf6f71 AS builder
LABEL maintainer=dadrus@gmx.de

ARG TARGETARCH
ARG VERSION="unknown"

ENV USER=test
ENV UID=10001

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN useradd -l -s "/sbin/nologin" -M -U -r -u ${UID} ${USER}

WORKDIR /app

COPY . .
RUN go mod download && GOOS=linux GOARCH=$TARGETARCH go build -a -trimpath -ldflags="-buildid= -w -s -X github.com/dadrus/github-integrations/version.Version=${VERSION}"

# The actual image of the app
FROM scratch
LABEL maintainer=dadrus@gmx.de

WORKDIR /opt/github-integrations

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /app/github-integrations .

USER ${USER}:${USER}

ENTRYPOINT ["/opt/github-integrations/github-integrations"]
