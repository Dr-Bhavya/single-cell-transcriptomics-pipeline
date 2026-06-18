FROM rocker/r-ver:latest
# 1. Install required system tracking libraries
RUN apt-get update && apt-get install -y \
    procps \
    libhdf5-dev \
    libgit2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libglpk-dev \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('stringi', type='source', repos='https://cloud.r-project.org')"
# 2. Pull pre-compiled binary versions of Seurat to protect your server's memory
RUN R -e "install.packages(c('Matrix','Seurat', 'tidyverse'), repos='https://packagemanager.posit.co/cran/__linux__/jammy/latest')"
WORKDIR /pipeline
