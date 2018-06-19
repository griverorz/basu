FROM opencpu/base

# install latex packages
RUN apt-get update -y \
    && apt-get install -y \
    pandoc

COPY . /basu
WORKDIR /basu

EXPOSE 5656

ENTRYPOINT ["Rscript"]
CMD ["setup.R"]


