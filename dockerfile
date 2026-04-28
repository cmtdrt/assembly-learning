FROM ubuntu:latest

RUN apt update && apt install -y nasm gcc make

WORKDIR /workspace