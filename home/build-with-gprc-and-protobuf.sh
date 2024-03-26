mkdir -p cmake/build && \
cd cmake/build && \
cmake -DCMAKE_PREFIX_PATH=/usr/local ../.. && \
make -j$(nproc)