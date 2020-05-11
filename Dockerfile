FROM rocker/tidyverse:3.5.3
LABEL maintainer="Dan Thal <dthal@mathematica-mpr.com>"

ENV PILOT=STATE
ENV GROUP=RG
ENV OUTCOME=Y
ENV WARMUP=WM
ENV DRAWS=DW
ENV THIN=THN
ENV CHAINS=CHN

#install deps for linux / R   ##any need to restrict these to older versions?
RUN apt-get update -y && \
        apt-get install -y \
        libxml2-dev \
        libgit2-dev \
        libpng-dev \
        libudunits2-dev \
        libgdal-dev \
        curl \
		git \
        awscli

EXPOSE 8787

#install scripts to container
RUN git clone https://github.com/MPRdthal/50695_docker_test.git
RUN cd 50695_docker_test
RUN ls -la

#ENTRYPOINT ["R", "-e", "run_run_test.R", PILOT, GROUP, OUTCOME, WARMUP, DRAWS, THIN, CHAINS]
ENTRYPOINT Rscript /run_run_test.R PILOT GROUP OUTCOME WARMUP DRAWS THIN CHAINS
