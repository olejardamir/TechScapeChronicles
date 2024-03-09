#!/bin/bash

# Define the repository URL
REPO_URL="https://github.com/pingcap/tidb.git"
# Define the directory name
DIR_NAME="tidb"

# Check if the directory exists
if [ -d "$DIR_NAME" ]; then
  echo "Removing existing '$DIR_NAME' directory..."
  rm -rf "$DIR_NAME"
fi

# Clone the source code
git clone "$REPO_URL" "$DIR_NAME"

# Change directory to tidb
cd "$DIR_NAME"

# Check if Go is installed
if command -v go &> /dev/null; then
  echo "Go is installed. Proceeding with the setup."
else
  echo "Error: Go is not installed. Please install Go and run the script again."
  exit 1
fi

# Set up a temporary directory for GOPATH
TEMP_GOPATH=$(mktemp -d)
export GOPATH=$TEMP_GOPATH

# Initialize the Go module
GO111MODULE=off go mod init tidb

# Build TiDB from the source code
make

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "TiDB build successful."
else
  echo "Error: TiDB build failed. Please check the previous error messages."
  exit 1
fi

# Run TiDB server
./bin/tidb-server &

# Wait for the server to start (you can customize this based on your system)
sleep 5

# Connect to TiDB using the MySQL client
mysql -h 127.0.0.1 -P 4000 -u root -D test --prompt="tidb> " --comments
