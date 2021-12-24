ARG PROJECT
FROM ${PROJECT}_europe_europe:latest

ARG WORK=iberia_africa

ENV LANG=C.UTF-8 \
    TZ=CDT6CST

WORKDIR /europe/${WORK}

CMD ./iberia_africa.sh && cp -v iberia_africa.pdf /pdf
