# syntax = docker/dockerfile:experimental
# Builder image to build the app
FROM --platform=$BUILDPLATFORM golang:1.24.1@sha256:52ff1b35ff8de185bf9fd26c70077190cd0bed1e9f16a2d498ce907e5c421268 as builder
LABEL maintainer=dadrus@gmx.de

ARG TARGETARCH
ARG VERSION="unknown"

ENV USER=test
ENV UID=10001

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN useradd -l -s "/sbin/nologin" -M -U -r -u ${UID} ${USER}

WORKDIR /app

COPY . .
RUN go mod download && GOOS=linux GOARCH=$TARGETARCH go build -a -trimpath -ldflags="-buildid= -w -s -X main.Version=${VERSION}"

# The actual image of the app
FROM scratch
LABEL maintainer=dadrus@gmx.de

WORKDIR /opt/github-integrations

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /app/github-integrations .

USER ${USER}:${USER}

ENTRYPOINT ["/opt/github-integrations/github-integrations"]
