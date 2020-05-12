args = commandArgs(trailingOnly=TRUE)
write.csv(args, 'stupid_test.csv')
system(glue::glue('aws s3 cp stupid_test.csv s3://50695-test/htmls/stupid_test_{args[1]}.csv'))
print('Bye')
