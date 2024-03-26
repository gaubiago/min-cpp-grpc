# Containerization of Protobuf and C++ GRPC

## How to Build the Image

```shell
./build-image.sh
```

or

```shell
docker build -t min-cpp-grpc:1.0 -f my.debian.dockerfile .
```

## Test the Image

This testing goes along the lines of [gRPC Quick Start](https://grpc.io/docs/languages/cpp/quickstart/).

* Clone the [grpc](https://github.com/grpc/grpc) repo into the [home](home) directory:
    ```shell
    git clone --recurse-submodules -b v1.62.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc
    ```
  
* Mac users, ensure the path to `docker` (executable) has been added to `PATH`:

    ```shell
    source add-docker-bin-to-path.sh
    ```
    
    or 
    
    ```shell
    export PATH="$HOME/.docker/bin:$PATH"
    ```

* Start the container:

    ```shell
    ./start-container.sh
    ```
    
    or 
    
    ```shell
    # Check if the container exists
    if docker ps -a --format '{{.Names}}' | grep -q "min-cpp-grpc"; then
        echo "Container min-cpp-grpc already exists. Starting it..."
        docker start min-cpp-grpc
    else
        echo "Container min-cpp-grpc does not exist. Creating and starting it..."
        docker run -dit -v $(pwd)/home:/home --name min-cpp-grpc min-cpp-grpc:1.0
    fi
    ```

* Test the **helloword** program:

  * Change directory into **helloword**:

    ```shell
    cd /home/grpc/examples/cpp/helloworld
    ```
    
  * Build the example using `cmake`:
  
    ```shell
    /home/build-with-gprc-and-protobuf.sh
    ```
    
    or
  
    ```shell
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DCMAKE_PREFIX_PATH=/usr/local ../.. && \
    make -j$(nproc)
    ```
    
  * Change directory into the **build** folder:

    ```shell
    cd /home/grpc/examples/cpp/helloworld/cmake/build
    ```  

  * Run server and client using different terminals:

    * Server:
    
      ```shell
      ./greeter_server
      ```

    * Client:

      ```shell
      ./greeter_client
      ```
      
## gRPC Basics Tutorial Commands

The gRPC Basics Tutorial can be found [here](https://grpc.io/docs/languages/cpp/basics/).

```shell
cd /home/grpc/examples/cpp/route_guide
```

```shell
/home/build-with-gprc-and-protobuf.sh
```

```shell
cd /home/grpc/examples/cpp/route_guide/cmake/build
```

```shell
./route_guide_server --db_path=../../route_guide_db.json
```

```shell
./route_guide_client --db_path=../../route_guide_db.json
```
