#!/bin/bash

# Example for Ubuntu/Debian:
sudo apt update
sudo apt install -y git curl

# Remove any existing Go installation
sudo rm -rf /usr/local/go

# Specify the Go version
TIDB_GOVERSION="1.22.1"

# Download and extract the specified Go version
GO_URL="https://go.dev/dl/go${TIDB_GOVERSION}.linux-amd64.tar.gz"

# Download and extract the Go archive
sudo wget $GO_URL -O go.tar.gz
sudo tar -C /usr/local -xzf go.tar.gz
sudo rm go.tar.gz

# Add /usr/local/go/bin to the PATH environment variable
export PATH=$PATH:/usr/local/go/bin

# Add the export PATH command to ~/.bashrc for persistence
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

# Verify the installation
go version
