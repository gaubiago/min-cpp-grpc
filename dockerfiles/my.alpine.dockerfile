FROM alpine:3.19.1

# NOTE: Does not work. Seems like grpc+protobuf expects glibc, but Alpine uses musl libc.

# Commands based on:
#   - https://grpc.io/docs/languages/cpp/quickstart/#install-other-required-tools
#   - https://hub.docker.com/r/grpc/cxx/dockerfile
RUN apk update && \
    apk add --no-cache libstdc++ g++ cmake && \
    apk add --no-cache --virtual .build-deps build-base linux-headers \
    autoconf git pkgconf automake libtool curl make unzip

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
    rm -rv /grpc && \
    rm -rf /var/cache/apk/* && \
    apk del .build-deps