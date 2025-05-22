FROM golang:1.24 AS builder

WORKDIR /app
COPY . .
RUN go env -w GO111MODULE=off && CGO_ENABLED=0 go build -o helloworld .

FROM alpine
WORKDIR /app
COPY --from=builder /app/helloworld .
EXPOSE 8080
CMD ["./helloworld"]

