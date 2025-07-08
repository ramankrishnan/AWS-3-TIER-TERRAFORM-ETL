output "s3_bucket_name" {
  value = aws_s3_bucket.weather_data.id
}

output "lambda_function_name" {
  value = aws_lambda_function.fetch_weather.function_name
}