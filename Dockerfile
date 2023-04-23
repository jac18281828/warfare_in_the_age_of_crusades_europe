FROM ghcr.io/jac18281828/bedrock:bed as builder

WORKDIR /bedrock

ARG WEST=-15
ARG EAST=35
ARG NORTH=65
ARG SOUTH=25

RUN gmt grdcut /bedrock/ETOPO_2022_v1_30s_N90W180_bed.nc -R${WEST}/${EAST}/${SOUTH}/${NORTH} -G/bedrock/ETOPO_europe.nc

FROM debian:stable-slim
ARG NAME=iberia

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y -q --no-install-recommends \
    gmt gmt-gshhg-high ghostscript \
    git curl gnupg2 \
    ca-certificates apt-transport-https && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --create-home -s /bin/bash jac
RUN usermod -a -G sudo jac
RUN echo '%jac ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers    

COPY --from=builder /bedrock/ETOPO_europe.nc /bedrock/ETOPO_europe.nc

ENV LANG=C.UTF-8 \
        TZ=CDT6CST \
        NAME=${NAME}

WORKDIR /europe

ENV USER=jac
USER jac
COPY --chown=jac.jac . .
