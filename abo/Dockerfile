FROM ubuntu:20.04 as toolset


RUN apt -q update
RUN apt -y install samtools
RUN apt -y install wget

### download reference
RUN wget https://hgdownload.cse.ucsc.edu/goldenpath/hg38/bigZips/hg38.2bit

### install blat
RUN wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/blat
RUN chmod +x blat

### install faToTwoBit
RUN wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/faToTwoBit
RUN chmod +x faToTwoBit
RUN apt -y install libcurl4-openssl-dev curl

### download query sequences
ENV NG=NG_033868.1
ENV NM=NM_021996.5
RUN curl "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=${NM}&rettype=fasta" > ${NM}.fa
RUN curl "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=${NG}&rettype=fasta" > ${NG}.fa

RUN ./faToTwoBit ${NM}.fa ${NM}.2bit
RUN ./faToTwoBit ${NG}.fa ${NG}.2bit

### get positon
RUN ./blat hg38.2bit ${NG}.2bit ${NG}.psl -tileSize=12 -minScore=100 -minIdentity=98
RUN cat ${NG}.psl | tail -n +6 | awk '{print $14":"$16"-"$17}' > range


