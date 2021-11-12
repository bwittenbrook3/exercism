FROM elixir:1.13-alpine

RUN wget https://github.com/exercism/cli/releases/download/v3.0.13/exercism-3.0.13-linux-x86_64.tar.gz && \
    tar xzf exercism-3.0.13-linux-x86_64.tar.gz && \
    mv exercism /usr/local/bin/

ARG EXERCISM_TOKEN

RUN mkdir -p /workspace/elixir && \
    exercism configure --token=$EXERCISM_TOKEN --workspace=\workspace

WORKDIR /workspace/elixir