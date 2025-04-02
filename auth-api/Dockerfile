FROM golang:1.18.2-alpine AS build
WORKDIR /app
COPY . .
RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api && \
    go mod tidy && \
    go build -o auth-api .

FROM alpine:latest
WORKDIR /app
COPY --from=build /app/auth-api .
EXPOSE 8000
CMD ["./auth-api"]