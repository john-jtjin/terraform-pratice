resource "aws_iam_policy" "random-time-sqs" {
  name = "random-time-sqs"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      "Effect" = "Allow",
      "Action" = "sqs:SendMessage",
      Resource = module.sqs.sqs_queue_arn
    }]
  })
}

// random-time lambda can send msg to sqs
resource "aws_iam_role_policy_attachment" "random-time-sqs" {
  role       = module.random_time.lambda_role_name
  policy_arn = aws_iam_policy.random-time-sqs.arn
}


// sqs can trigger check-104 lambda
resource "aws_iam_role_policy_attachment" "lambda_sqs_role_policy" {
  role       = module.check_104.lambda_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
}


resource "aws_iam_policy" "check-104-sns" {
  name = "check-104-sqs"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      "Effect" = "Allow",
      "Action" = "sns:Publish",
      Resource = aws_sns_topic.sns.arn
    }]
  })
}


// check-104 lambda can send msg to sns
resource "aws_iam_role_policy_attachment" "check-104-sns" {
  role       = module.check_104.lambda_role_name
  policy_arn = aws_iam_policy.check-104-sns.arn
}