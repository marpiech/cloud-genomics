ARG REPOSITORY=marpiech
ARG IMAGE_NAME=gnomad
ARG VERSION=v3.1.1
ARG TIMESTAMP=30.09.2021

FROM marpiech/ubuntu:20.04

RUN for i in {1..22}; \
  do \
  wget https://storage.googleapis.com/gcp-public-data--gnomad/release/3.1.1/vcf/genomes/gnomad.genomes.v3.1.1.sites.chr$i.vcf.bgz -O gnomad.genomes.v3.1.1.sites.chr$i.vcf.gz; \
  wget https://storage.googleapis.com/gcp-public-data--gnomad/release/3.1.1/vcf/genomes/gnomad.genomes.v3.1.1.sites.chr$i.vcf.bgz.tbi -O gnomad.genomes.v3.1.1.sites.chr$i.vcf.gz.tbi; \
  done
RUN wget https://storage.googleapis.com/gcp-public-data--gnomad/release/3.1.1/vcf/genomes/gnomad.genomes.r3.1.1.sites.chrX.vcf.bgz -O gnomad.genomes.r3.1.1.sites.chrX.vcf.gz
RUN wget https://storage.googleapis.com/gcp-public-data--gnomad/release/3.1.1/vcf/genomes/gnomad.genomes.r3.1.1.sites.chrX.vcf.bgz.tbi -O gnomad.genomes.r3.1.1.sites.chrX.vcf.gz.tbi

