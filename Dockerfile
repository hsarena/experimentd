FROM dlang2/dmd-ubuntu as build
WORKDIR /dlang/app
COPY . .
RUN dub build -v

FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y zlib1g libssl1.1 && \
  rm -rf /var/lib/apt/lists/*
COPY --from=build /dlang/app /
USER nobody
ENTRYPOINT ["/experimentd"]
