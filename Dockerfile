FROM ubuntu:24.04

RUN apt update -y
RUN apt install openssl -y

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
