FROM jac18281828/bedrock:latest as builder

WORKDIR /bedrock

ARG WEST=-5
ARG EAST=15
ARG NORTH=55
ARG SOUTH=25

RUN ls -l /bedrock
RUN gmt grdcut /bedrock/ETOPO_2022_v1_30s_N90W180_bed.nc -R${WEST}/${EAST}/${SOUTH}/${NORTH} -G/bedrock/ETOPO_europe.nc

FROM debian:stable-slim
ARG NAME

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y -q --no-install-recommends \
    gmt gmt-gshhg-high ghostscript && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /bedrock/ETOPO_europe.nc /bedrock/ETOPO_europe.nc


ENV LANG=C.UTF-8 \
        TZ=CDT6CST \
        NAME=${NAME}

WORKDIR /europe

ARG WORK=${NAME}
WORKDIR /europe/${WORK}
COPY . .

CMD ./build_map.sh
