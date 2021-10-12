ARG REPOSITORY=marpiech
ARG IMAGE_NAME=dbsnp
ARG VERSION=155-grch38
ARG TIMESTAMP=5.10.2021

FROM marpiech/reference:grch38-no-alt AS reference

FROM marpiech/ubuntu:20.04 AS worker
ARG VERSION=155

RUN wget "https://ftp.ncbi.nih.gov/snp/archive/b$VERSION/VCF/GCF_000001405.39.gz"
RUN wget "https://ftp.ncbi.nih.gov/snp/archive/b$VERSION/VCF/GCF_000001405.39.gz.tbi"
RUN wget "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.39_GRCh38.p13/GCF_000001405.39_GRCh38.p13_assembly_report.txt"

RUN cat GCF_000001405.39_GRCh38.p13_assembly_report.txt | \
  grep -e '^[^#]' | \
  awk '{ print $7, $11 }' > GCF_000001405.39_GRCh38.p13_assembly_report.chrnames

RUN bcftools annotate \
  --rename-chrs GCF_000001405.39_GRCh38.p13_assembly_report.chrnames \
  --threads 10 -Oz \
  -o dbsnp"$VERSION".grch38.random.vcf.gz \
  GCF_000001405.39.gz

RUN zcat dbsnp155.grch38.random.vcf.gz | grep -P '^#|^chr' | grep -v chrUn | grep -v _random | bcftools annotate -x INFO | bgzip -c > dbsnp155.grch38.vcf.gz

RUN tabix -p vcf dbsnp155.grch38.vcf.gz

COPY --from=reference GRCh38.no_alt_analysis_set.fa ./
COPY --from=reference GRCh38.no_alt_analysis_set.fa.fai ./

RUN bcftools norm -c x -f GRCh38.no_alt_analysis_set.fa dbsnp155.grch38.vcf.gz | bgzip -c > dbsnp155.grch38.norm.vcf.gz
RUN tabix -p vcf dbsnp155.grch38.norm.vcf.gz

FROM marpiech/polygenicmaker:2.0.22 AS indexer
COPY --from=worker dbsnp155.grch38.vcf.gz dbsnp155.grch38.vcf.gz
COPY --from=worker dbsnp155.grch38.vcf.gz.tbi dbsnp155.grch38.vcf.gz.tbi
COPY --from=worker dbsnp155.grch38.norm.vcf.gz dbsnp155.grch38.norm.vcf.gz
COPY --from=worker dbsnp155.grch38.norm.vcf.gz.tbi dbsnp155.grch38.norm.vcf.gz.tbi
RUN polygenicmaker vcf-index --vcf dbsnp155.grch38.vcf.gz
RUN polygenicmaker vcf-index --vcf dbsnp155.grch38.norm.vcf.gz

FROM scratch
COPY --from=indexer dbsnp155.grch38.vcf.gz dbsnp155.grch38.vcf.gz
COPY --from=indexer dbsnp155.grch38.vcf.gz.tbi dbsnp155.grch38.vcf.gz.tbi
COPY --from=indexer dbsnp155.grch38.vcf.gz.idx.db dbsnp155.grch38.vcf.gz.idx.db
COPY --from=indexer dbsnp155.grch38.norm.vcf.gz dbsnp155.grch38.norm.vcf.gz
COPY --from=indexer dbsnp155.grch38.norm.vcf.gz.tbi dbsnp155.grch38.norm.vcf.gz.tbi
COPY --from=indexer dbsnp155.grch38.norm.vcf.gz.idx.db dbsnp155.grch38.norm.vcf.gz.idx.db
