ARG PROJECT
FROM ${PROJECT}_bedrock_europe:latest

ENV LANG=C.UTF-8 \
    TZ=CDT6CST

WORKDIR /europe

ARG WORK=iberia
WORKDIR /europe/${WORK}
COPY . .

CMD ./iberia.sh
