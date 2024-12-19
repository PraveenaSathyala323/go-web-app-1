# Stage 1: Build
FROM golang:1.20 AS builder

# Set the working directory
WORKDIR /app

# Copy the Go modules files
COPY go.mod .

# Download dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the application
RUN go build -o app .

# Stage 2: Run
FROM debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=builder /app/app .

# Expose the application's port (optional, replace with your app's port)
EXPOSE 8080

# Run the application
CMD ["./app"]





