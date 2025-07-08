resource "aws_secretsmanager_secret" "weather_api" {
  name = "weather_api_key"
}

resource "aws_secretsmanager_secret_version" "weather_api_key_value" {
  secret_id     = aws_secretsmanager_secret.weather_api.id
  secret_string = jsonencode({
    api_key = var.weather_api_key
  })
}