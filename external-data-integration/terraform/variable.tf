variable "weather_api_key" {
  description = "API key for OpenWeather"
  type        = string
  sensitive   = true
}

variable "project_name" {
  default = "external-weather-pipeline"
}

variable "aws_region" {
  default = "us-east-1"
}
