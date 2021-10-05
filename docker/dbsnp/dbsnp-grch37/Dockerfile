ARG REPOSITORY=marpiech
ARG IMAGE_NAME=dbsnp-grch37
ARG VERSION=155
ARG TIMESTAMP=30.09.2021

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

RUN tabix -p vcf GRCh37.dbSNP"$VERSION".vcf.gz
RUN bcftools norm -c x -f genome/GRCh37.no_alt_analysis_set.fa.gz GRCh37.dbSNP"$VERSION".vcf.gz GRCh37.dbSNP$VERSION.norm.vcf.gz -O z
