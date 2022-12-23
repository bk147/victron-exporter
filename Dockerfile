# Invoked from goreleaser, uses binaries build by goreleaser
FROM golang:latest AS goapp
ENV CGO_ENABLED=0 GOOS=linux
RUN mkdir -p /usr/src/exporter
COPY . /usr/src/exporter
WORKDIR /usr/src/exporter
RUN go build

FROM alpine:latest AS production
WORKDIR /usr/local/bin
COPY --from=goapp /usr/src/exporter/victron-exporter .
ENTRYPOINT ["/usr/local/bin/victron-exporter"]

#docker build -t ve .
#docker run -it --entrypoint /bin/bash ve