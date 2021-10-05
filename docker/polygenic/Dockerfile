ARG REPOSITORY=marpiech
ARG IMAGE_NAME=polygenic
ARG VERSION=2.0.20
ARG TIMESTAMP=3.10.2021

FROM marpiech/dbsnp-grch38:138 AS dbsnp38
FROM marpiech/dbsnp-grch37:138 AS dbsnp37
FROM marpiech/gnomad:v3.1.1 AS gnomad

FROM marpiech/ubuntu:20.04
COPY from=dbsnp38 dbsnp138.38.vcf.gz dbSNP138.38.vcf.gz
COPY from=dbsnp37 dbsnp138.37.vcf.gz dbsnp138.37.vcf.gz
COPY from=gnomad af.vcf.gz* .
