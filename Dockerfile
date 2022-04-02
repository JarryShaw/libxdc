# Build Stage
FROM ubuntu:20.04

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang git

RUN git clone https://github.com/aquynh/capstone.git && \
    cd capstone && \
    git checkout v4 && \
    make && \
    make install

## Add source code to the build stage.
COPY . /libxdc
WORKDIR /libxdc

RUN make && \
    bash compile_libfuzzer.sh

## TODO: Change <Path in Builder Stage>
#COPY --from=builder /libxdc/libfuzzer_bin/tester /
