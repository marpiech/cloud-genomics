ARG REPOSITORY=marpiech
ARG IMAGE_NAME=dbsnp-grch38
ARG VERSION=155
ARG TIMESTAMP=1.10.2021

FROM marpiech/reference:grch38-no-alt AS reference

FROM marpiech/ubuntu:20.04 AS worker
ARG VERSION

RUN wget "https://ftp.ncbi.nih.gov/snp/archive/b$VERSION/VCF/GCF_000001405.39.gz"
RUN wget "https://ftp.ncbi.nih.gov/snp/archive/b$VERSION/VCF/GCF_000001405.39.gz.tbi"
RUN wget "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.39_GRCh38.p13/GCF_000001405.39_GRCh38.p13_assembly_report.txt"

RUN cat GCF_000001405.39_GRCh38.p13_assembly_report.txt | \
  grep -e '^[^#]' | \
  awk '{ print $7, $11 }' > GCF_000001405.39_GRCh38.p13_assembly_report.chrnames

RUN bcftools annotate \
  --rename-chrs GCF_000001405.39_GRCh38.p13_assembly_report.chrnames \
  --threads 10 -Oz \
  -o GRCh38.dbSNP"$VERSION".vcf.gz \
  GCF_000001405.39.gz

RUN zcat GRCh38.dbSNP155.vcf.gz | grep -P '^#|^chr' | grep -v chrUn | grep -v _random | bgzip -c > GRCh38.dbSNP155.no_alt.vcf.gz

RUN tabix -p vcf GRCh38.dbSNP"$VERSION".no_alt.vcf.gz

COPY --from=reference GRCh38.no_alt_analysis_set.fa ./
COPY --from=reference GRCh38.no_alt_analysis_set.fa.fai ./

RUN bcftools norm -c x -f GRCh38.no_alt_analysis_set.fa GRCh38.dbSNP"$VERSION".no_alt.vcf.gz | bgzip -c > GRCh38.dbSNP$VERSION.norm.vcf.gz
