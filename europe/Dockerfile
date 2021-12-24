FROM jac18281828/gmt:110521 as builder

WORKDIR /bedrock

ARG WEST=-15
ARG EAST=42
ARG NORTH=45
ARG SOUTH=29

RUN gmt grdcut /bedrock/ETOPO1_Bed_g_gmt4.grd -R${WEST}/${EAST}/${SOUTH}/${NORTH} -G/bedrock/ETOPO1_europe.grd

FROM debian:stable-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
        apt update && \
        apt install -y -q --no-install-recommends \
        gmt gmt-gshhg-high ghostscript

RUN rm -rf /var/lib/apt/lists/*

COPY --from=builder /bedrock/ETOPO1_europe.grd /bedrock/ETOPO1_europe.grd

CMD echo Bedrock!
