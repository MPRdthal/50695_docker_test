args = commandArgs(trailingOnly=TRUE)
rmarkdown::render('/50695_docker_test/run_test.rmd', params=list(grantee=args[1], group=args[2], outcome=args[3], warmup=as.numeric(args[4]), draws=as.numeric(args[5]), thin=as.numeric(args[6]), chains=as.numeric(args[7]), cores=as.numeric(args[7])))
system(glue::glue('aws s3 cp run_test.html s3://50695-test/htmls/fake_{args[3]}_{args[1]}_{args[2]}.html'))
