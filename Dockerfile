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
WORKDIR /home/50695_docker_test

ENTRYPOINT ["R", "-e", "rmarkdown::render(run_test.rmd, params=list(grantee=PILOT, group=GROUP, outcome=Y, warmup=WM, draws=DW, thin=THN, chains=CHN, cores=CHN)"]
RUN aws s3 cp run_test.html s3://50695-test/htmls/fake_Y_PILOT_GROUP.html
