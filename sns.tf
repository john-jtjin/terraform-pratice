resource "aws_sns_topic" "sns" {
  name = "check-104-sns"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.sns.arn
  protocol  = "email"
  endpoint  = var.email
}