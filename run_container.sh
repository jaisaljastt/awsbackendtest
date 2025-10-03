#!/bin/bash
# Script to run Docker container with proper environment variables

docker run -p 80:8000 -d --name awsbackend-app \
  -e SECRET_KEY="your-secret-key" \
  -e DEBUG=False \
  -e ALLOWED_HOSTS="localhost,127.0.0.1" \
  -e DB_NAME="your_db_name" \
  -e DB_USER="your_db_user" \
  -e DB_PASSWORD="your_db_password" \
  -e DB_HOST="your-db-host" \
  -e DB_PORT="3306" \
  -e AWS_ACCESS_KEY_ID="your-aws-access-key" \
  -e AWS_SECRET_ACCESS_KEY="your-aws-secret-key" \
  -e AWS_STORAGE_BUCKET_NAME="backendjaisalaws" \
  -e AWS_S3_REGION_NAME="eu-north-1" \
  040692276326.dkr.ecr.eu-north-1.amazonaws.com/awsbackend:latest