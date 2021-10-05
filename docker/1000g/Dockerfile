ARG REPOSITORY=marpiech
ARG IMAGE_NAME=1000g
ARG VERSION=all
ARG TIMESTAMP=5.10.2021

FROM marpiech/ubuntu:20.04
RUN for i in $(seq 22) X; \
  do \
    wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/release/20190312_biallelic_SNV_and_INDEL/ALL.chr"$i".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz; \
    wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/release/20190312_biallelic_SNV_and_INDEL/ALL.chr"$i".shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz.tbi; \
  done


RUN wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel

