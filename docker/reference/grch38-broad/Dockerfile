ARG REPOSITORY=marpiech
ARG IMAGE_NAME=reference
ARG VERSION=grch38-broad
ARG TIMESTAMP=30.09.2021

FROM marpiech/ubuntu:20.04 as worker

RUN wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Homo_sapiens_assembly38.fasta.gz
RUN wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Homo_sapiens_assembly38.fasta.fai
RUN wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Homo_sapiens_assembly38.fasta.64.alt
RUN wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Homo_sapiens_assembly38.dict
