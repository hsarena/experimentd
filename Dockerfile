
FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y zlib1g libssl1.1 && \
  rm -rf /var/lib/apt/lists/*
COPY /experimentd /
USER nobody
ENTRYPOINT ["/experimentd"]
