FROM debian:bullseye AS build

# Set environment variables
ENV GROUP=redis
ENV USER=redis
ENV ROOT=/opt

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    musl \
    make \
    redis-tools \
    linux-headers-amd64 \
    wget \
    libssl-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user and set permissions
RUN addgroup --system ${USER} && adduser --system --ingroup ${GROUP} ${USER}
RUN mkdir -p ${ROOT} && chown ${USER}:${GROUP} ${ROOT}

# Clone and build Predixy
WORKDIR /opt
RUN git clone https://github.com/joyieldInc/predixy.git && cd predixy \
    && make \
    && cp src/predixy /usr/local/bin/