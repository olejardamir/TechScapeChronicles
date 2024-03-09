Sure, here's a step-by-step procedure to install the requirements outlined in the document:

### Step 1: Install Golang

1.  Open a terminal on your development environment.
    
2.  Check if Go is already installed by typing:
    
    goCopy code
    
    `go version`
    
3.  If Go is not installed or you need a specific version, follow the instructions in the document to find the required version in the go.mod file:
    
    perlCopy code
    
    `curl -s -S -L https://github.com/pingcap/tidb/blob/master/go.mod | grep -Eo "\"go [[:digit:]]+.[[:digit:]]+\""`
    
4.  Visit the Go download page (https://golang.org/dl/) and download the version you obtained in the previous step.
    
5.  Follow the installation instructions for your operating system.
    

### Step 2: Manage the Go toolchain using gvm

6.  If you are using Linux or MacOS, install gvm by running the following command:
    
    rubyCopy code
    
    `curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | sh`
    
7.  Once gvm is installed, install and set the default Go version using the information from the go.mod file:
    
    perlCopy code
    
    `TIDB_GOVERSION=$(curl -s -S -L https://github.com/pingcap/tidb/blob/master/go.mod | grep -Eo "\"go [[:digit:]]+.[[:digit:]]+\"" | grep -Eo "[[:digit:]]+.[[:digit:]]+") gvm install go${TIDB_GOVERSION} gvm use go${TIDB_GOVERSION} --default`
    
8.  Verify the installation by typing:
    
    goCopy code
    
    `go version`
    
    The output should confirm that the installed Go version matches the one specified in the go.mod file.
    

### Step 3: Verification

9.  Confirm the successful installation by running:
    
    goCopy code
    
    `go version`
    
    The output should display the correct Go version.
    

Congratulations! You've successfully installed Golang and set up the Go toolchain using gvm. Now you're ready to proceed with obtaining the TiDB source code and building it, as mentioned in the next chapter of the document. If you encounter any issues, refer to the TiDB Internals forum for assistance.
