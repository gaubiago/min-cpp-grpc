FROM debian:12.5-slim

# Commands based on:
#   - https://grpc.io/docs/languages/cpp/quickstart/#install-other-required-tools
#   - https://hub.docker.com/r/grpc/cxx/dockerfile
RUN apt-get update && apt-get install -y \
    build-essential autoconf git pkg-config \
    automake libtool curl make g++ unzip cmake \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Commands based on:
#   - https://grpc.io/docs/languages/cpp/quickstart/#clone-the-grpc-repo
#   - https://grpc.io/docs/languages/cpp/quickstart/#build-and-install-grpc-and-protocol-buffers
RUN git clone --recurse-submodules -b v1.62.0 --depth 1 \
    --shallow-submodules https://github.com/grpc/grpc && \
    cd grpc && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DgRPC_INSTALL=ON \
          -DgRPC_BUILD_TESTS=OFF \
          ../.. && \
    make -j$(nproc) && \
    make install && \
    rm -rv /grpc