ARG REPOSITORY=marpiech
ARG IMAGE_NAME=reference
ARG VERSION=grch38-broad
ARG TIMESTAMP=5.10.2021

FROM marpiech/ubuntu:20.04 as worker

RUN wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta -O grch38.broad.fa
RUN wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.fai -O grch38.broad.fa.fai
RUN wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.dict -O grch38.broad.dict
