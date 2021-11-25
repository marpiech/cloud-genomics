
ARG REPOSITORY=marpiech
ARG IMAGE_NAME=1000genomes
ARG VERSION=all
ARG TIMESTAMP=5.10.2021

FROM marpiech/ubuntu:20.04
#RUN for i in $(seq 22) X; \
RUN for i in 22; \
  do  \
    wget http://hgdownload.soe.ucsc.edu/gbdb/hg38/1000Genomes/ALL.chr"$i".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz; \
    wget http://hgdownload.soe.ucsc.edu/gbdb/hg38/1000Genomes/ALL.chr"$i".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz.tbi; \
  done


RUN wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel

RUN bcftools concat -o - $(ls *.vcf.gz | sort -k1,1 -V) | bgzip -c > 1000g.vcf.gz
RUN tabix -p vcf 1000g.vcf.gz
