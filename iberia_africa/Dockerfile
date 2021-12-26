ARG PROJECT
FROM ${PROJECT}_bedrock_europe:latest

ENV LANG=C.UTF-8 \
    TZ=CDT6CST

WORKDIR /europe

ARG WORK=iberia_africa
COPY . ${WORK}
WORKDIR /europe/${WORK}

CMD ./iberia_africa.sh
