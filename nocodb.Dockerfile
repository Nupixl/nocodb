# syntax=docker/dockerfile:1

###########
# Litestream Builder
###########
FROM golang:bullseye AS lt-builder
WORKDIR /usr/src/
RUN apt-get update && apt-get install -y git make gcc libc-dev && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/benbjohnson/litestream.git litestream
RUN cd litestream && go install ./cmd/litestream
RUN cp $GOPATH/bin/litestream /usr/src/lt

###########
# Builder
###########
FROM node:22-slim AS builder
WORKDIR /usr/src/app

# Install dependencies required for node-gyp and other build tools
RUN apt-get update && apt-get install -y \
    python3 \
    python3-distutils \
    python-is-python3 \
    make \
    g++ \
    libssl-dev \
    libsqlite3-dev \
    pkg-config \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install pnpm
RUN corepack enable && corepack prepare pnpm@9.15.4 --activate

# Copy the entire monorepo
COPY . .

# Configure pnpm to use hoisted node_modules
RUN echo "node-linker=hoisted" > .npmrc

# Install all dependencies without running scripts
RUN pnpm install --no-frozen-lockfile --ignore-scripts

# Build sqlite3 bindings for the target Node ABI
RUN npm_config_build_from_source=true pnpm --filter social-pixl rebuild sqlite3

# Build the SDK first
WORKDIR /usr/src/app/packages/social-pixl-sdk
RUN pnpm run build

# Build nocodb
WORKDIR /usr/src/app/packages/nocodb
RUN pnpm run build

##########
# Runner
##########
FROM node:22-slim
WORKDIR /usr/src/app

ENV NC_DOCKER=0.6 \
    NC_TOOL_DIR=/usr/app/data/ \
    NODE_ENV=production \
    PORT=8080

# Install additional runtime dependencies and build tools for native modules
RUN apt-get update && apt-get install -y \
    dumb-init \
    curl \
    wget \
    python3 \
    python3-distutils \
    make \
    g++ \
    libsqlite3-dev \
    pkg-config \
    && curl -L "https://github.com/TomWright/dasel/releases/download/v2.8.1/dasel_linux_$(dpkg --print-architecture)" -o /usr/local/bin/dasel \
    && chmod +x /usr/local/bin/dasel \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install pnpm in the runner stage as Railway may require it for starting the service
RUN corepack enable && corepack prepare pnpm@9.15.4 --activate

# Copy litestream binary
COPY --link --from=lt-builder /usr/src/lt /usr/local/bin/litestream

# Copy the built application and dependencies from builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/packages/nocodb ./packages/nocodb
COPY --from=builder /usr/src/app/packages/social-pixl-sdk ./packages/social-pixl-sdk
COPY --from=builder /usr/src/app/package.json ./package.json
COPY --from=builder /usr/src/app/pnpm-workspace.yaml ./pnpm-workspace.yaml
COPY --from=builder /usr/src/app/pnpm-lock.yaml ./pnpm-lock.yaml
COPY --from=builder /usr/src/app/.npmrc ./.npmrc

# Setup start script
WORKDIR /usr/src/app/packages/nocodb
RUN mkdir -p /usr/src/appEntry && cp docker/start-litestream.sh /usr/src/appEntry/start.sh
RUN chmod +x /usr/src/appEntry/start.sh

EXPOSE 8080
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/src/appEntry/start.sh"]
