#!/bin/bash

# update and install requirements:
sudo apt update
sudo apt install -y git curl build-essential mysql-client

# Remove existing Go installations
sudo rm -rf /usr/local/go

# Download and extract the specified Go version
TIDB_GOVERSION=$(curl -s -S -L https://raw.githubusercontent.com/pingcap/tidb/master/go.mod | awk '/^go / {gsub(/[^0-9.]/,"",$2); print $2}')

echo "*************************"
echo "$TIDB_GOVERSION"
echo "*************************"

# Function to download and extract Go version
download_and_extract() {
    GO_URL="https://golang.org/dl/go$1.linux-amd64.tar.gz"
    sudo wget $GO_URL -O go.tar.gz
    if [ $? -ne 0 ]; then
        echo "Download failed for version $1."
    else
        sudo tar -C /usr/local -xzf go.tar.gz
        echo "Go version $1 installed successfully."
        return 0
    fi
    return 1
}

# Check the number of decimal points in the version
decimal_points=$(echo "$TIDB_GOVERSION" | tr -cd '.' | wc -c)

if [ "$decimal_points" -eq 1 ]; then
    # Version has one decimal point, try versions 1.x.0 to 1.x.9
    for i in {0..9}; do
        version_to_try="$TIDB_GOVERSION.$i"
        download_and_extract "$version_to_try" && break
    done
elif [ "$decimal_points" -eq 2 ]; then
    # Version has two decimal points, try versions 1.x.y to 1.x.9
    for i in {0..9}; do
        for j in {0..9}; do
            version_to_try="$TIDB_GOVERSION.$i.$j"
            download_and_extract "$version_to_try" && break 2
        done
    done
else
    # Unsupported version format
    echo "Unsupported Go version format: $TIDB_GOVERSION"
    exit 1
fi

# Add /usr/local/go/bin to the PATH environment variable
export PATH=$PATH:/usr/local/go/bin

# Add the export PATH command to ~/.bashrc for persistence
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

# Verify the installation
go version
