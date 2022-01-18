ARG REPOSITORY=intelliseq
ARG IMAGE_NAME=polygenic
ARG VERSION=2.1.4
ARG TIMESTAMP=18.1.2022

FROM marpiech/ubuntu:20.04
RUN apt update -qq && apt install -y python3-pip
RUN pip3 install --upgrade polygenic==2.1.4
