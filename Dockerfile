FROM alpine:latest as builder

ARG VERSION=0.8.12
ARG SHA=e7e2f2656247004a726c07142deca7d91dd8e94e

RUN apk add --update alpine-sdk wget bash unzip
RUN DIR=$(mktemp -d) && cd ${DIR} && \
    wget -q https://github.com/z3APA3A/3proxy/archive/${VERSION}.zip && \
    echo "$SHA  $VERSION.zip" | sha1sum -c - && \
    unzip ${VERSION}.zip && \
    cd 3proxy-${VERSION} && \
    make -f Makefile.Linux && \
    cd src && mv 3proxy /home/ && \
    chmod +x /home/3proxy

FROM alpine:latest
RUN apk add --update bash
WORKDIR /home
COPY --from=builder /home/3proxy .
COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh
STOPSIGNAL SIGTERM
EXPOSE 3128/tcp
HEALTHCHECK --interval=30s --timeout=10s --start-period=2s --retries=2 CMD [ "nc", "-z", "-w5", "localhost", "3128" ]
ENTRYPOINT ["./entrypoint.sh"]
