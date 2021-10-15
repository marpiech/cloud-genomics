ARG REPOSITORY=marpiech
ARG IMAGE_NAME=ensembl-genes
ARG VERSION=104
ARG TIMESTAMP=12.10.2021

FROM marpiech/ubuntu:20.04 as worker
RUN wget -O - 'http://www.ensembl.org/biomart/martservice?query=<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE Query><Query  virtualSchemaName = "default" formatter = "TSV" header = "0" uniqueRows = "0" count = "" datasetConfigVersion = "0.6" ><Dataset name = "hsapiens_gene_ensembl" interface = "default" ><Filter name = "biotype" value = "protein_coding"/><Filter name = "transcript_appris" excluded = "0"/><Filter name = "transcript_biotype" value = "protein_coding"/><Attribute name = "chromosome_name" /><Attribute name = "start_position" /><Attribute name = "end_position" /><Attribute name = "ensembl_gene_id" /><Attribute name = "external_gene_name" /></Dataset></Query>' | \
    sort -k1,1V | \
    sed '1i chromosome\tstart\tend\tensembl_id\tsymbol' | \
    awk 'NF == 5' > ensembl-genes.tsv

FROM scratch
COPY --from=worker ensembl-genes.tsv ensembl-genes.tsv