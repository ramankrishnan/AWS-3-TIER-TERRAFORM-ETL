# SNS Topic
resource "aws_sns_topic" "cpu_alerts" {
  name = "cpu-alert-topic"
}

# SNS Email Subscription
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.cpu_alerts.arn
  protocol  = "email"
  endpoint  = "*********@gmail.com"  # <-- Change if needed
}

# CloudWatch Alarm: CPU > 35%
resource "aws_cloudwatch_metric_alarm" "cpu_warn_alarm" {
  alarm_name          = "CPU-Warn-Above-35"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 35
  alarm_description   = "Alarm when CPU exceeds 35% for 4 minutes."
  alarm_actions       = [aws_sns_topic.cpu_alerts.arn]
  ok_actions          = [aws_sns_topic.cpu_alerts.arn]

  dimensions = {
    InstanceId = "i-09*****88"  # <-- Replace with your instance ID
  }
}
