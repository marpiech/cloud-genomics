
ARG REPOSITORY=marpiech
ARG IMAGE_NAME=1000genomes
ARG VERSION=all
ARG TIMESTAMP=15.12.2021

FROM marpiech/ubuntu:20.04 as builder
RUN for i in $(seq 22) X; \
  do  \
    wget http://hgdownload.soe.ucsc.edu/gbdb/hg38/1000Genomes/ALL.chr"$i".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz; \
    wget http://hgdownload.soe.ucsc.edu/gbdb/hg38/1000Genomes/ALL.chr"$i".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz.tbi; \
  done


RUN wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel

RUN bcftools concat -o - $(ls *.phased.vcf.gz | sort -k1,1 -V) | bgzip -c > 1000g.vcf.gz
RUN tabix -p vcf 1000g.vcf.gz

FROM marpiech/dbsnp:155-grch38 AS dbsnp38

FROM marpiech/ubuntu:20.04 as annotator
COPY --from=dbsnp38 dbsnp155.grch38.norm.vcf.gz dbsnp155.grch38.norm.vcf.gz
COPY --from=dbsnp38 dbsnp155.grch38.norm.vcf.gz.tbi dbsnp155.grch38.norm.vcf.gz.tbi
COPY --from=builder 1000g.vcf.gz 1000g.vcf.gz
COPY --from=builder 1000g.vcf.gz.tbi 1000g.vcf.gz.tbi
# annotate iwth rsid
RUN bcftools annotate 1000g.vcf.gz -c "ID" -a dbsnp155.grch38.norm.vcf.gz --collapse none -o 1000g.rs.vcf.gz -O z 
RUN tabix -p vcf 1000g.rs.vcf.gz

FROM marpiech/ubuntu:20.04
COPY --from=worker 1000g.rs.vcf.gz 1000g.rs.vcf.gz
COPY --from=worker 1000g.rs.vcf.gz.tbi 1000g.rs.vcf.gz.tbi
COPY --from=builder integrated_call_samples_v3.20130502.ALL.panel all.panel
