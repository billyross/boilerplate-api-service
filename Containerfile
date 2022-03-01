# Prepare a builder image and build the project
FROM golang:1.17 AS builder
WORKDIR /build
COPY . .
RUN make build

# Fetch a final image, copy the binary and expose and start the service
FROM gcr.io/distroless/base-debian11
COPY --from=builder /build/bin/boilerplate /
EXPOSE 8080
CMD ["/boilerplate"]