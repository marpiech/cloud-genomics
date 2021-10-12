ARG REPOSITORY=marpiech
ARG IMAGE_NAME=biobank-gbe-index
ARG VERSION=1.3.1
ARG TIMESTAMP=6.10.2021

FROM marpiech/ubuntu:20.04 AS worker
RUN wget https://biobankengine.stanford.edu/prs -O - | \
    grep "Standing height" | \
    sed 's/<tr>/\n/g' | \
    sed 's|</tr>||g' | \
    sed 's/<td>/\t/g' | \
    sed 's|</td>||g' | \
    sed 's|</a>||g' | \
    sed 's/<tr role="row" class="even">/\n/g' | \
    sed 's/<tr role="row" class="odd">/\n/g' | \
    sed 's/^\t//' | \
    sed 's/<a href="//' | \
    sed 's/">/\t/' | \
    tail +2 | \
    sed 's|<.*>||g' | \
    sed 's|https://biobankengine.stanford.edu/RIVAS_HG19/snpnet/||' | \
    sed '1i Trait group\tTrait name\tID\tFamily\tGenotype predictive performance\tCovariates predictive performance\tFull predictive performance\tDelta\tNumber of variants\tP\tSignificant' \
    > gbe-index.1.3.1.tsv

FROM scratch
COPY --from=worker gbe-index.1.3.1.tsv gbe-index.1.3.1.tsv
