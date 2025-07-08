resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name                = "DailyWeatherTrigger"
  schedule_expression = "rate(1 hour)"  # Adjust as needed
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  target_id = "WeatherLambda"
  arn       = aws_lambda_function.fetch_weather.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fetch_weather.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_trigger.arn
}