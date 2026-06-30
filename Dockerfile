FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    # Native host compiler (needed for scripts/basic/fixdep and other host tools)
    gcc \
    g++ \
    # Cross-compiler toolchain
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    # Build essentials
    make \
    bc \
    bison \
    flex \
    # Kernel crypto/certs support
    libssl-dev \
    libelf-dev \
    # Script dependencies
    python3 \
    perl \
    # Compressed module signing / initramfs tools
    zstd \
    # Device tree compiler
    device-tree-compiler \
    # For menuconfig (optional but handy)
    libncurses-dev \
    # Misc
    git \
    ca-certificates \
    wget \
    xz-utils \
    cpio \
    rsync \
    file \
    && rm -rf /var/lib/apt/lists/*

ENV ARCH=arm64
ENV CROSS_COMPILE=aarch64-linux-gnu-

COPY build.sh /usr/local/bin/build.sh
RUN chmod +x /usr/local/bin/build.sh

WORKDIR /kernel

CMD ["/bin/bash"]
