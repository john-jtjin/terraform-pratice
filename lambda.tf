module "random_time" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.0.0"

  function_name = "random-time"
  description   = "random-time (0~600s)"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = {
    path             = "${path.module}/resources/random-time"
    npm_requirements = true,
  }

  environment_variables = {
    SQS_PATH : module.sqs.sqs_queue_id
  }
  tags = {
    Name = "random-time"
  }
}

module "check_104" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.0.0"

  function_name = "check-104"
  description   = "check-104"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = {
    path             = "${path.module}/resources/check-104"
    npm_requirements = true,
  }

  environment_variables = {
    SNS_PATH : aws_sns_topic.sns.arn,
    # CID : var.CID
  }
  tags = {
    Name = "check-104"
  }
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = module.sqs.sqs_queue_arn
  enabled          = true
  function_name    = module.check_104.lambda_function_name
}