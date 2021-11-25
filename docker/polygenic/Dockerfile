ARG REPOSITORY=intelliseq
ARG IMAGE_NAME=polygenic
ARG VERSION=2.0.36
ARG TIMESTAMP=24.11.2021

FROM marpiech/ubuntu:20.04
RUN apt update -qq && apt install -y python3-pip
RUN pip3 install --upgrade polygenic==2.0.36
