ARG REPOSITORY=marpiech
ARG IMAGE_NAME=reference
ARG VERSION=grch37-broad
ARG TIMESTAMP=1.10.2021

FROM marpiech/ubuntu:20.04 as worker

RUN wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg19/ucsc.hg19.fasta.gz
RUN wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg19/ucsc.hg19.fasta.fai.gz
RUN wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg19/ucsc.hg19.fasta.fai.gz

RUN gunzip ucsc.hg19.fasta.gz
RUN gunzip ucsc.hg19.fasta.fai.gz
RUN gunzip ucsc.hg19.dict.gz
