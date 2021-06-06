FROM debian:10 AS build

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y wget git && \
    wget -qO- https://get.haskellstack.org/ | sh && \
    git clone https://github.com/Gabscap/InfoProxy.git git && \
    cd /git && \
    stack --local-bin-path / install

FROM debian:10

RUN mkdir /data

COPY --from=build /InfoProxy /InfoProxy

WORKDIR /data

CMD ["/InfoProxy", "-f", "config.yml"]

EXPOSE 25565/udp