resource "aws_s3_bucket" "weather_data" {
  bucket = "${var.project_name}-weather-data"
  force_destroy = true
}