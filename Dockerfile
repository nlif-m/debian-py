FROM docker.io/library/debian:12
ENV PYTHON_VERSION=3.11.*
RUN apt-get update -y && \
    apt-get install -y python3=$PYTHON_VERSION &&  \
    rm -rf /var/lib/apt/lists/*
