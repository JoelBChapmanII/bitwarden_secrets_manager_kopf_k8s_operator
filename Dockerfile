FROM ghcr.io/flant/shell-operator:latest

# Install base dependencies
RUN apk add git pkgconfig openssl-dev perl make

# Install rust dependencies
RUN apk add rust cargo

# Install the bitwarden client
RUN git clone https://github.com/bitwarden/sdk.git
RUN cd sdk && cargo install bws && rm -rf sdk

# Add the shell-operator hooks to our app
ADD hooks /hooks
