terraform {
    source = "tfr:///terraform-aws-modules/lambda/aws?version=6.0.0"
}

inputs = {
    function_name = "kkkk"
    handler       = "index.handler"
    runtime       = "nodejs18.x"
}