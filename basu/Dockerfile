FROM opencpu/base

COPY . /basu
WORKDIR /basu

RUN Rscript -e 'devtools::install(".")'
RUN Rscript -e 'opencpu:::ocpu_start_app("basu")'

