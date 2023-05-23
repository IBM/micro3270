################## Build / Compile Stage ##################
FROM registry.access.redhat.com/ubi8/ubi-minimal:latest AS builder
RUN microdnf update -y \
    && microdnf install -y git make gcc ncurses-devel
WORKDIR src
COPY scripts/build-c3270.sh .
RUN ./build-c3270.sh

# ################## Final Image ##################
FROM registry.access.redhat.com/ubi8/ubi-micro:latest
COPY --from=builder /usr/local/bin/c3270 /usr/local/bin/.
ENV ENV=/run-c3270
COPY LICENSE .
COPY NOTICES .
RUN echo 'exec c3270 $ZOS_HOST $ZOS_PORT' > /run-c3270
ENTRYPOINT ["c3270"]