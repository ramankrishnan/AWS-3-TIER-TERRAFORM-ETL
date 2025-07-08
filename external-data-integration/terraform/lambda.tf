resource "aws_lambda_function" "fetch_weather" {
  function_name = "FetchWeatherFunction"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "fetch_weather.lambda_handler"
  runtime       = "python3.9"

  filename         = "${path.module}/../lambda/fetch_weather.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda/fetch_weather.zip")
  timeout = 15 
  environment {
    variables = {
      SECRET_NAME = aws_secretsmanager_secret.weather_api.name
      S3_BUCKET   = aws_s3_bucket.weather_data.bucket
    }
  }
}