ARG REPOSITORY=marpiech
ARG IMAGE_NAME=dbsnp-grch37
ARG VERSION=155
ARG TIMESTAMP=5.10.2021

FROM marpiech/reference:grch37-broad AS reference

FROM marpiech/ubuntu:20.04 as worker
ARG VERSION

RUN wget "https://ftp.ncbi.nih.gov/snp/archive/b$VERSION/VCF/GCF_000001405.25.gz"
RUN wget "https://ftp.ncbi.nih.gov/snp/archive/b$VERSION/VCF/GCF_000001405.25.gz"
RUN wget "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.25_GRCh37.p13/GCF_000001405.25_GRCh37.p13_assembly_report.txt"

RUN cat GCF_000001405.25_GRCh37.p13_assembly_report.txt | \
  grep -e '^[^#]' | \
  awk '{ print $7, $11 }' > GCF_000001405.25_GRCh37.p13_assembly_report.chrnames

RUN wget "https://ftp.ncbi.nih.gov/snp/archive/b$VERSION/VCF/GCF_000001405.25.gz.tbi"

RUN bcftools annotate \
  --rename-chrs GCF_000001405.25_GRCh37.p13_assembly_report.chrnames \
  --threads 10 -Oz \
  -o GRCh37.dbSNP"$VERSION".vcf.gz \
  GCF_000001405.25.gz

RUN zcat GRCh37.dbSNP"$VERSION".vcf.gz | grep -P '^#|^chr' | grep -v '^chrUn' | grep -v '_random' | bgzip -c  > dbsnp"$VERSION".grch37.vcf.gz
RUN tabix -p vcf dbsnp"$VERSION".grch37.vcf.gz

COPY --from=reference grch37.broad.fa grch37.broad.fa
COPY --from=reference grch37.broad.fa.fai grch37.broad.fa.fai
COPY --from=reference grch37.broad.dict grch37.broad.dict

RUN bcftools norm -c x -f grch37.broad.fa dbsnp"$VERSION".grch37.vcf.gz -O z dbsnp"$VERSION".grch37.norm.vcf.gz
RUN tabix -p vcf dbsnp"$VERSION".grch37.norm.vcf.gz
