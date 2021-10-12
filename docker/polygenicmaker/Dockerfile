ARG REPOSITORY=marpiech
ARG IMAGE_NAME=polygenicmaker
ARG VERSION=2.0.22
ARG TIMESTAMP=6.10.2021

FROM marpiech/dbsnp:138-grch38 AS dbsnp38
FROM marpiech/dbsnp:138-grch37 AS dbsnp37
FROM marpiech/gnomad:v3.1.1 AS gnomad

FROM marpiech/polygenic:2.0.20 AS index
COPY --from=dbsnp37 dbsnp138.37.norm.vcf.gz dbsnp138.37.norm.vcf.gz
COPY --from=dbsnp37 dbsnp138.37.norm.vcf.gz.tbi dbsnp138.37.norm.vcf.gz.tbi
RUN polygenicmaker vcf-index --vcf dbsnp138.37.norm.vcf.gz

COPY --from=dbsnp38 dbsnp138.38.norm.vcf.gz dbsnp138.38.norm.vcf.gz
COPY --from=dbsnp38 dbsnp138.38.norm.vcf.gz.tbi dbsnp138.38.norm.vcf.gz.tbi
RUN polygenicmaker vcf-index --vcf dbsnp138.38.norm.vcf.gz

COPY --from=gnomad af.vcf.gz gnomad.3.1.vcf.gz
COPY --from=gnomad af.vcf.gz.tbi gnomad.3.1.vcf.gz.tbi
RUN polygenicmaker vcf-index --vcf gnomad.3.1.vcf.gz

RUN pip3 install --upgrade polygenic==2.0.22
