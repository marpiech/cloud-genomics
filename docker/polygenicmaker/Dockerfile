ARG REPOSITORY=marpiech
ARG IMAGE_NAME=polygenicmaker
ARG VERSION=2.0.26
ARG TIMESTAMP=6.10.2021

FROM marpiech/dbsnp:155-grch38 AS dbsnp38
FROM marpiech/dbsnp:155-grch37 AS dbsnp37
FROM marpiech/gnomad:v3.1.1 AS gnomad
FROM marpiech/ensembl-genes:104 AS ensembl

FROM marpiech/polygenic:2.0.20 AS index
COPY --from=dbsnp37 dbsnp155.grch37.norm.vcf.gz dbsnp155.grch37.norm.vcf.gz
COPY --from=dbsnp37 dbsnp155.grch37.norm.vcf.gz.tbi dbsnp155.grch37.norm.vcf.gz.tbi
COPY --from=dbsnp37 dbsnp155.grch37.norm.vcf.gz.idx.db dbsnp155.grch37.norm.vcf.gz.idx.db

COPY --from=dbsnp38 dbsnp155.grch38.norm.vcf.gz dbsnp155.grch38.norm.vcf.gz
COPY --from=dbsnp38 dbsnp155.grch38.norm.vcf.gz.tbi dbsnp155.grch38.norm.vcf.gz.tbi
COPY --from=dbsnp38 dbsnp155.grch38.norm.vcf.gz.idx.db dbsnp155.grch38.norm.vcf.gz.idx.db

COPY --from=gnomad af.vcf.gz gnomad.3.1.vcf.gz
COPY --from=gnomad af.vcf.gz.tbi gnomad.3.1.vcf.gz.tbi
RUN polygenicmaker vcf-index --vcf gnomad.3.1.vcf.gz

COPY --from=ensembl ensembl-genes.tsv ensembl-genes.104.tsv

RUN pip3 install --upgrade polygenic==2.0.26
