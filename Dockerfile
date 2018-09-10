FROM opencpu/base

# install latex packages
RUN apt-get update -y \
    && apt-get install -y \
    pandoc

COPY setup.R .
COPY index.Rmd .
COPY basu basu

EXPOSE 5656

ENTRYPOINT ["Rscript"]
CMD ["setup.R"]


