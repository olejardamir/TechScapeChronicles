#!/bin/bash

# Step 1: Install Golang
echo "Step 1: Install Golang"
if command -v go &> /dev/null; then
    echo "Golang is already installed. Skipping installation."
else
    GO_VERSION=$(curl -s -S -L https://github.com/pingcap/tidb/blob/master/go.mod | grep -Eo "\"go [[:digit:]]+.[[:digit:]]+\"" | grep -Eo "[[:digit:]]+.[[:digit:]]+")
    echo "Downloading and installing Go ${GO_VERSION}..."
    curl -s -S -L https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz | sudo tar -C /usr/local -xz
    export PATH=$PATH:/usr/local/go/bin
fi

# Step 2: Manage the Go toolchain using gvm
echo "Step 2: Manage the Go toolchain using gvm"
if command -v gvm &> /dev/null; then
    echo "gvm is already installed. Skipping installation."
else
    echo "Installing gvm..."
    curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
    source ~/.gvm/scripts/gvm
fi

TIDB_GOVERSION=$(curl -s -S -L https://github.com/pingcap/tidb/blob/master/go.mod | grep -Eo "\"go [[:digit:]]+.[[:digit:]]+\"" | grep -Eo "[[:digit:]]+.[[:digit:]]+")

echo "Installing and setting Go ${TIDB_GOVERSION} as default..."
gvm install go${TIDB_GOVERSION}
gvm use go${TIDB_GOVERSION} --default

# Step 3: Verification
echo "Step 3: Verification"
echo "Verifying Go installation..."
go version

echo "Installation completed successfully!"
