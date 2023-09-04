FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl nano wget telnet mysql-server
WORKDIR /app
CMD service mysql start 