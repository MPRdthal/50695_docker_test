FROM rocker/tidyverse:3.5.3
LABEL maintainer="Dan Thal <dthal@mathematica-mpr.com>"

ENV PILOT=MS
ENV GROUP=treat
ENV OUTCOME=TERNFQ4
ENV WARMUP=100
ENV DRAWS=100
ENV THIN=2
ENV CHAINS=4

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

RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN install2.r -d TRUE -n 4 --error \
      glue

EXPOSE 8787

#install scripts to container
ADD https://api.github.com/repos/MPRdthal/50695_docker_test/git/refs/heads/master version.json
RUN git clone https://github.com/MPRdthal/50695_docker_test.git
WORKDIR /50695_docker_test
RUN ls -la

#ENTRYPOINT ["R", "-e", "run_run_test.R", PILOT, GROUP, OUTCOME, WARMUP, DRAWS, THIN, CHAINS]
#ENTRYPOINT Rscript run_run_test.R $PILOT $GROUP $OUTCOME $WARMUP $DRAWS $THIN $CHAINS
ENTRYPOINT ["Rscript", "really_dumb_test.R", $PILOT, $GROUP, $OUTCOME, $WARMUP, $DRAWS, $THIN, $CHAINS]
