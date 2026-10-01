# syntax = docker/dockerfile:experimental@sha256:600e5c62eedff338b3f7a0850beb7c05866e0ef27b2d2e8c02aa468e78496ff5
# Builder image to build the app
FROM --platform=$BUILDPLATFORM golang:1.26.1@sha256:c42e4d75186af6a44eb4159dcfac758ef1c05a7011a0052fe8a8df016d8e8fb9 as builder
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
