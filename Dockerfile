ARG PROJECT
FROM ${PROJECT}_bedrock_europe:latest

WORKDIR /europe

COPY iberia_africa iberia_africa/

CMD echo 'Bedrock for Europe'
