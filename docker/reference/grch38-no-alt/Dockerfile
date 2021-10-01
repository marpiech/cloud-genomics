ARG REPOSITORY=marpiech
ARG IMAGE_NAME=reference
ARG VERSION=grch38-no-alt
ARG TIMESTAMP=30.09.2021

FROM marpiech/ubuntu:20.04 as worker

RUN wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz
RUN wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.fai
RUN wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.bwa_index.tar.gz

RUN tar -xvf GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.bwa_index.tar.gz
RUN rm GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.bwa_index.tar.gz

RUN mv GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz GRCh38.no_alt_analysis_set.fa.gz
RUN gunzip GRCh38.no_alt_analysis_set.fa.gz
RUN mv GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.fai GRCh38.no_alt_analysis_set.fa.fai
RUN mv GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.amb GRCh38.no_alt_analysis_set.fa.amb
RUN mv GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.ann GRCh38.no_alt_analysis_set.fa.ann
RUN mv GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.bwt GRCh38.no_alt_analysis_set.fa.bwt
RUN mv GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.pac GRCh38.no_alt_analysis_set.fa.pac
RUN mv GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.sa GRCh38.no_alt_analysis_set.fa.sa

