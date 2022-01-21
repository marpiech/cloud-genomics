FROM ubuntu:20.04 as convertf
RUN apt -qq update && apt -y install git build-essential
RUN git clone https://github.com/DReichLab/AdmixTools.git
RUN apt -y install libgsl-dev libopenblas-dev
RUN cd /AdmixTools/src && make
RUN cd /AdmixTools/src && make install

FROM ubuntu:20.04 as downloader
RUN mkdir /tools
COPY --from=convertf /AdmixTools/bin/convertf /tools/convertf
RUN apt -qq update && apt -y install wget
RUN mkdir /data
RUN cd /data && wget https://reichdata.hms.harvard.edu/pub/datasets/amh_repo/curated_releases/V50/V50.0/SHARE/public.dir/v50.0_HO_public.anno
RUN cd /data && wget https://reichdata.hms.harvard.edu/pub/datasets/amh_repo/curated_releases/V50/V50.0/SHARE/public.dir/v50.0_HO_public.ind
RUN cd /data && wget https://reichdata.hms.harvard.edu/pub/datasets/amh_repo/curated_releases/V50/V50.0/SHARE/public.dir/v50.0_HO_public.snp
RUN cd /data && wget https://reichdata.hms.harvard.edu/pub/datasets/amh_repo/curated_releases/V50/V50.0/SHARE/public.dir/v50.0_HO_public.geno

RUN echo 'genotypename:    /data/v50.0_HO_public.geno' > /data/par.EIGENSTRAT.PED && \
  echo 'snpname:         /data/v50.0_HO_public.snp' >> /data/par.EIGENSTRAT.PED && \
  echo 'indivname:       /data/v50.0_HO_public.ind' >> /data/par.EIGENSTRAT.PED && \
  echo 'outputformat: PACKEDPED' >> /data/par.EIGENSTRAT.PED && \
  echo 'genotypeoutname: /data/v50.0_HO_public.bed' >> /data/par.EIGENSTRAT.PED && \
  echo 'snpoutname: /data/v50.0_HO_public.bim' >> /data/par.EIGENSTRAT.PED && \
  echo 'indivoutname: /data/v50.0_HO_public.fam' >> /data/par.EIGENSTRAT.PED
RUN /tools/convertf -p /data/par.EIGENSTRAT.PED

FROM ubuntu:20.04 as vcfgenerator
RUN mkdir /data
COPY --from=downloader /data/v50.0_HO_public.bed /data/v50.0_HO_public.bed
COPY --from=downloader /data/v50.0_HO_public.bim /data/v50.0_HO_public.bim
COPY --from=downloader /data/v50.0_HO_public.fam /data/v50.0_HO_public.fam
RUN apt -qq update && apt -y install wget unzip
RUN mkdir /tools && cd /tools && wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20210606.zip
RUN cd /tools && unzip plink_linux_x86_64_20210606.zip
RUN /tools/plink --bfile /data/v50.0_HO_public --recode vcf --out /data/v50.0_HO_public

FROM ubuntu:20.04 as liftover
RUN mkdir /data
COPY --from=vcfgenerator /data/v50.0_HO_public.vcf /data/v50.0_HO_public.vcf
RUN apt -qq update && apt -y install gzip wget python3 python3-pip
RUN pip3 install CrossMap
RUN cd /data && wget https://hgdownload.cse.ucsc.edu/goldenpath/hg19/liftOver/hg19ToHg38.over.chain.gz
RUN cd /data && wget https://hgdownload.cse.ucsc.edu/goldenpath/hg38/bigZips/hg38.fa.gz && gzip -d hg38.fa.gz
RUN CrossMap.py vcf /data/hg19ToHg38.over.chain.gz /data/v50.0_HO_public.vcf /data/hg38.fa /data/v50.0_HO_public.hg38.vcf

