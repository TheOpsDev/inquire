# Build Stage
FROM lacion/alpine-golang-buildimage:1.13 AS build-stage

LABEL app="build-inquire"
LABEL REPO="https://github.com/TheOpsDev/inquire"

ENV PROJPATH=/go/src/github.com/TheOpsDev/inquire

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/TheOpsDev/inquire
WORKDIR /go/src/github.com/TheOpsDev/inquire

RUN make build-alpine

# Final Stage
FROM golang:1.21.3-alpine

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/TheOpsDev/inquire"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/inquire/bin

WORKDIR /opt/inquire/bin

COPY --from=build-stage /go/src/github.com/TheOpsDev/inquire/bin/inquire /opt/inquire/bin/
RUN chmod +x /opt/inquire/bin/inquire

# Create appuser
RUN adduser -D -g '' inquire
USER inquire

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/inquire/bin/inquire"]
