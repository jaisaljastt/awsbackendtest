# LearningAWS - Django REST API with S3 Storage

A Django REST API application that demonstrates AWS integration for file uploads to S3 buckets, using RDS for database storage, and deployed via ECR.

## Local Development Setup

### Prerequisites

- Docker and Docker Compose
- Python 3.12+
- AWS Account with S3 and RDS configured

### Setup Instructions

1. Clone the repository:

   ```bash
   git clone https://github.com/jaisaljastt/awsbackend.git
   cd awsbackend
   ```

2. Create a `.env` file with required environment variables:

   ```
   # Django settings
   SECRET_KEY=your-secret-key
   DEBUG=True
   ALLOWED_HOSTS=localhost,127.0.0.1

   # Database settings
   DB_NAME=django
   DB_USER=admin
   DB_PASSWORD=password
   DB_HOST=db
   DB_PORT=3306

   # AWS settings
   AWS_ACCESS_KEY_ID=your-aws-access-key
   AWS_SECRET_ACCESS_KEY=your-aws-secret-key
   AWS_STORAGE_BUCKET_NAME=backendjaisalaws
   AWS_S3_REGION_NAME=eu-north-1
   ```

3. Start the application with Docker Compose:

   ```bash
   docker-compose up --build
   ```

4. Access the application at http://localhost:8000/

## AWS ECR Deployment

### Setting up AWS Resources

1. Create an ECR repository:

   ```bash
   aws ecr create-repository --repository-name awsbackend
   ```

2. Configure your AWS credentials:
   ```bash
   aws configure
   ```

### Pushing to ECR Manually

1. Authenticate Docker to ECR:

   ```bash
   aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 040692276326.dkr.ecr.eu-north-1.amazonaws.com
   ```

2. Build the Docker image:

   ```bash
   docker build -t awsbackend .
   ```

3. Tag the image:

   ```bash
   docker tag awsbackend:latest 040692276326.dkr.ecr.eu-north-1.amazonaws.com/awsbackend:latest
   ```

4. Push the image to ECR:
   ```bash
   docker push 040692276326.dkr.ecr.eu-north-1.amazonaws.com/awsbackend:latest
   ```

### CI/CD with GitHub Actions

This repository includes GitHub Actions workflow for automatic deployment to ECR.

To set it up:

1. Add the following secrets to your GitHub repository:

   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `DJANGO_SECRET_KEY`
   - `ALLOWED_HOSTS`
   - `DB_NAME`
   - `DB_USER`
   - `DB_PASSWORD`
   - `DB_HOST`
   - `DB_PORT`
   - `AWS_S3_ACCESS_KEY_ID`
   - `AWS_S3_SECRET_ACCESS_KEY`
   - `AWS_STORAGE_BUCKET_NAME`

2. Push to the main branch to trigger the workflow.

## Features

- REST API for CRUD operations
- File uploads to AWS S3
- MySQL/RDS database integration
- Containerized deployment
- CI/CD pipeline

## Project Structure

```
├── awsapp/                # Django app with API endpoints
├── LearningAWS/           # Project settings
├── .github/workflows/     # GitHub Actions CI/CD
├── docker-compose.yml     # Local development setup
├── Dockerfile             # Container definition
├── requirment.txt         # Python dependencies
└── run_container.sh       # Script to run container locally
```

## Using the GitHub Actions Workflow

The included GitHub Actions workflow automates the process of building and pushing your Docker image to Amazon ECR whenever you push to the main branch.

1. The workflow authenticates with AWS using the provided credentials
2. Builds the Docker image using the Dockerfile in the repository
3. Tags the image with the commit SHA for version tracking
4. Pushes the image to your ECR repository (040692276326.dkr.ecr.eu-north-1.amazonaws.com/awsbackend)

To view the status of your workflow runs, check the "Actions" tab in your GitHub repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
