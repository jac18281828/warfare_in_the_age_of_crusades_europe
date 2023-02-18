FROM jac18281828/bedrock:latest as builder

WORKDIR /bedrock

ARG WEST=-5
ARG EAST=5
ARG NORTH=50
ARG SOUTH=35

RUN gmt grdcut /bedrock/ETOPO_2022_v1_30s_N90W180_bed.nc -R${WEST}/${EAST}/${SOUTH}/${NORTH} -G/bedrock/ETOPO_europe.nc

FROM debian:stable-slim
ARG NAME

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y -q --no-install-recommends \
    gmt gmt-gshhg-high ghostscript && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8 \
        TZ=CDT6CST \
        NAME=${NAME}

WORKDIR /europe

ARG WORK=${NAME}
WORKDIR /europe/${WORK}
COPY . .

CMD ./build_map.sh
