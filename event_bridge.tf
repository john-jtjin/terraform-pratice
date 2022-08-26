// event bridge
resource "aws_cloudwatch_event_rule" "random_time_lambda_event_rule" {
  name                = "lambda-event-rule"
  description         = "retry scheduled every 20 min"
  schedule_expression = "rate(20 minutes)"
}

resource "aws_cloudwatch_event_target" "random_time_lambda_target" {
  arn  = module.random_time.lambda_function_arn
  rule = aws_cloudwatch_event_rule.random_time_lambda_event_rule.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_rw_fallout_retry_step_deletion_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.random_time.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.random_time_lambda_event_rule.arn
}