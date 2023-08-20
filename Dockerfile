FROM --platform=$BUILDPLATFORM golang:1.18-alpine as builder

ENV GO111MODULE=on

RUN apk --no-cache add git libc-dev gcc
RUN go install github.com/mjibson/esc@latest

COPY . /go/src/github.com/mailslurper/mailslurper
WORKDIR /go/src/github.com/mailslurper/mailslurper/cmd/mailslurper

RUN go get
RUN go generate
RUN go build

ADD assets/* ./

EXPOSE 8080 8085 2500

ENTRYPOINT ["./mailslurper"]
