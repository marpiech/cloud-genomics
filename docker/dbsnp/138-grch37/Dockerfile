ARG REPOSITORY=marpiech
ARG IMAGE_NAME=dbsnp
ARG VERSION=138-grch37
ARG TIMESTAMP=5.10.2021

FROM marpiech/reference:grch37-broad AS reference

FROM marpiech/ubuntu:20.04 as worker
RUN wget https://storage.googleapis.com/gcp-public-data--broad-references/hg19/v0/Homo_sapiens_assembly19.dbsnp.vcf
RUN cat Homo_sapiens_assembly19.dbsnp.vcf | bgzip -c > dbsnp138.37.vcf.gz
RUN rm Homo_sapiens_assembly19.dbsnp.vcf
RUN tabix -p vcf dbsnp138.37.vcf.gz

COPY --from=reference grch37.broad.fa grch37.broad.fa
COPY --from=reference grch37.broad.fa.fai grch37.broad.fa.fai
COPY --from=reference grch37.broad.dict grch37.broad.dict

RUN bcftools norm -c x -f grch37.broad.fa dbsnp138.37.vcf.gz -O z > dbsnp138.37.norm.vcf.gz
RUN tabix -p vcf dbsnp138.37.norm.vcf.gz

FROM ubuntu:20.04
COPY --from=worker dbsnp138.37.vcf.gz dbsnp138.37.vcf.gz
COPY --from=worker dbsnp138.37.vcf.gz.tbi dbsnp138.37.vcf.gz.tbi
COPY --from=worker dbsnp138.37.norm.vcf.gz dbsnp138.37.norm.vcf.gz
COPY --from=worker dbsnp138.37.norm.vcf.gz.tbi dbsnp138.37.norm.vcf.gz.tbi
