ARG REPOSITORY=marpiech
ARG IMAGE_NAME=dbsnp
ARG VERSION=138-grch38
ARG TIMESTAMP=5.010.2021

FROM marpiech/reference:grch38-broad AS reference

FROM marpiech/ubuntu:20.04 as worker
RUN wget https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf.gz -O dbsnp138.38.vcf.gz
RUN tabix -p vcf dbsnp138.38.vcf.gz

COPY --from=reference grch38.broad.fa grch38.broad.fa
COPY --from=reference grch38.broad.fa.fai grch38.broad.fa.fai
COPY --from=reference grch38.broad.dict grch38.broad.dict

RUN bcftools norm -c x -f grch38.broad.fa dbsnp138.38.vcf.gz -O z > dbsnp138.38.norm.vcf.gz
RUN tabix -p vcf dbsnp138.38.norm.vcf.gz

FROM ubuntu:20.04
COPY --from=worker dbsnp138.38.vcf.gz dbsnp138.38.vcf.gz
COPY --from=worker dbsnp138.38.vcf.gz.tbi dbsnp138.38.vcf.gz.tbi
COPY --from=worker dbsnp138.38.norm.vcf.gz dbsnp138.38.norm.vcf.gz
COPY --from=worker dbsnp138.38.norm.vcf.gz.tbi dbsnp138.38.norm.vcf.gz.tbi
