FROM jac18281828/bedrock:latest as builder

WORKDIR /bedrock

ARG WEST=-15
ARG EAST=20
ARG NORTH=50
ARG SOUTH=25

RUN gmt grdcut /bedrock/ETOPO1_Bed_g_gmt4.grd -R${WEST}/${EAST}/${SOUTH}/${NORTH} -G/bedrock/ETOPO1_europe.grd

FROM debian:stable-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
        apt update && \
        apt install -y -q --no-install-recommends \
        gmt gmt-gshhg-high ghostscript

RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

COPY --from=builder /bedrock/ETOPO1_europe.grd /bedrock/ETOPO1_europe.grd

CMD echo Bedrock!
