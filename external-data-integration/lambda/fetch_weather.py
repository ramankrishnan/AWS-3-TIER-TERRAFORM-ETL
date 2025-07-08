import boto3
import json
import requests
import os
from datetime import datetime

def lambda_handler(event, context):
    secret_name = os.environ['SECRET_NAME']
    region = os.environ['AWS_REGION']

    session = boto3.session.Session()
    client = session.client(service_name='secretsmanager', region_name=region)
    get_secret_value_response = client.get_secret_value(SecretId=secret_name)
    secret = json.loads(get_secret_value_response['SecretString'])
    api_key = secret['api_key']

    city = "Chennai"
    url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}"

    response = requests.get(url)
    data = response.json()

    s3 = boto3.client('s3')
    timestamp = datetime.utcnow().isoformat()
    file_name = f"{city}_{timestamp}.json"
    s3.put_object(
        Bucket=os.environ['S3_BUCKET'],
        Key=file_name,
        Body=json.dumps(data),
        ContentType='application/json'
    )

    return {
        'statusCode': 200,
        'body': json.dumps(f"Stored weather data for {city}")
    }