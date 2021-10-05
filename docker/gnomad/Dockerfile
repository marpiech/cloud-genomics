ARG REPOSITORY=marpiech
ARG IMAGE_NAME=gnomad
ARG VERSION=v3.1.1
ARG TIMESTAMP=30.09.2021

FROM marpiech/ubuntu:20.04

RUN wget http://anakin.intelliseq.pl/public/intelliseqngs/workflows/resources/vcf-annotations/frequencies/gnomad-af-3.1/af.vcf.gz
RUN wget http://anakin.intelliseq.pl/public/intelliseqngs/workflows/resources/vcf-annotations/frequencies/gnomad-af-3.1/af.vcf.gz.tbi
RUN wget http://anakin.intelliseq.pl/public/intelliseqngs/workflows/resources/vcf-annotations/frequencies/gnomad-af-3.1/af.vcf.gz.idx.db
