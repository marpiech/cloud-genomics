ARG REPOSITORY=marpiech
ARG IMAGE_NAME=polygenictk
ARG VERSION=2.0.36
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
COPY --from=gnomad af.vcf.gz.idx.db gnomad.3.1.vcf.gz.idx.db

COPY --from=ensembl ensembl-genes.tsv ensembl-genes.104.tsv

RUN wget https://downloads.intelliseq.com/public/intelliseqngs/mobigen/pgs_data/eur.phase3.biobank.set.vcf.gz
RUN wget https://downloads.intelliseq.com/public/intelliseqngs/mobigen/pgs_data/eur.phase3.biobank.set.vcf.gz.tbi
# RUN wget https://downloads.intelliseq.com/public/intelliseqngs/mobigen/pgs_data/eur.phase3.biobank.set.vcf.gz.idx.db

RUN wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20210606.zip
RUN apt update -qq && apt install -y unzip && unzip plink_linux_x86_64_20210606.zip
RUN ln -s /plink /usr/bin/plink

RUN pip3 install --upgrade polygenic==2.0.36
