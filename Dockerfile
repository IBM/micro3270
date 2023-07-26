################## Build / Compile Stage ##################
FROM registry.access.redhat.com/ubi8/ubi-minimal:latest AS builder
RUN microdnf update -y \
    && microdnf install -y git make gcc ncurses-devel openssl-devel
WORKDIR src
COPY scripts/build-c3270.sh .
RUN ./build-c3270.sh

# ################## Final Image ##################
FROM registry.access.redhat.com/ubi8/ubi-micro:latest

ENV ENV=/micro3270/entrypoint \
    C3270PRO=/micro3270/config/.c3270

COPY --from=builder /usr/local/bin/c3270 /usr/local/bin/.
COPY --from=builder /usr/lib64/libssl.so.* /usr/lib64/libcrypto.so.* /usr/lib64/libz.so.* /usr/lib64/.
COPY LICENSE NOTICES entrypoint /micro3270

WORKDIR /micro3270
ENTRYPOINT ["/micro3270/entrypoint"]