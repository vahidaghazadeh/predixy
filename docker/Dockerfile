# Build stage
FROM debian:bullseye AS build

ENV GROUP=redis
ENV USER=redis
ENV ROOT=/opt

# Install dependencies
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

# Set up a non-root user
RUN addgroup --system ${USER} && adduser --system --ingroup ${GROUP} ${USER}
RUN mkdir -p ${ROOT} && chown ${USER}:${GROUP} ${ROOT}

# Clone Predixy source code and build
WORKDIR /opt
RUN git clone https://github.com/joyieldInc/predixy.git && cd predixy \
    && make \
    && cp src/predixy /usr/local/bin/

# Runtime stage
FROM debian:bullseye AS runtime

ENV GROUP=redis
ENV USER=redis
ENV ROOT=/opt

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    redis-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up a non-root user
RUN addgroup --system ${USER} && adduser --system --ingroup ${GROUP} ${USER}
RUN mkdir -p ${ROOT} && chown ${USER}:${GROUP} ${ROOT}

# Copy built binary from build stage
COPY --from=build /usr/local/bin/predixy /usr/local/bin/predixy
COPY --from=build /opt/predixy/conf /etc/predixy

# Set working directory
WORKDIR /etc/predixy

# Expose Predixy default port
EXPOSE 7617

# Command to run Predixy
CMD ["/usr/local/bin/predixy", "predixy.conf"]
