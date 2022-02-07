ARG PROJECT
FROM ${PROJECT}_bedrock_europe:latest
ARG NAME

ENV LANG=C.UTF-8 \
        TZ=CDT6CST \
        NAME=${NAME}

WORKDIR /europe

ARG WORK=${NAME}
WORKDIR /europe/${WORK}
COPY . .

CMD ./build_map.sh
