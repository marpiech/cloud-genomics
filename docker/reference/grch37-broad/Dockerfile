ARG REPOSITORY=marpiech
ARG IMAGE_NAME=reference
ARG VERSION=grch37-broad
ARG TIMESTAMP=1.10.2021

FROM marpiech/ubuntu:20.04 as worker

RUN wget https://storage.googleapis.com/gcp-public-data--broad-references/hg19/v0/Homo_sapiens_assembly19.fasta -O grch37.broad.fa
RUN wget https://storage.googleapis.com/gcp-public-data--broad-references/hg19/v0/Homo_sapiens_assembly19.fasta.fai -O grch37.broad.fa.fai
RUN wget https://storage.googleapis.com/gcp-public-data--broad-references/hg19/v0/Homo_sapiens_assembly19.dict -O grch37.broad.dict
