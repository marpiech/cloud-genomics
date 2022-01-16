ARG REPOSITORY=intelliseq
ARG IMAGE_NAME=polygenic
ARG VERSION=2.1.3
ARG TIMESTAMP=12.1.2022

FROM marpiech/ubuntu:20.04
RUN apt update -qq && apt install -y python3-pip
RUN pip3 install --upgrade polygenic==2.1.3
