FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    default-libmysqlclient-dev \
    pkg-config \
    python3-dev \
    netcat-traditional \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirment.txt .
RUN pip install --upgrade pip && \
    pip install -r requirment.txt && \
    pip install gunicorn whitenoise

# Copy project
COPY . .

# Create directory for static files
RUN mkdir -p /app/staticfiles_build/static
RUN mkdir -p /app/media

# Expose port
EXPOSE 8000

# Create entrypoint script
RUN echo '#!/bin/bash \n\
set -e \n\
\n\
echo "Waiting for MySQL..." \n\
while ! nc -z $DB_HOST $DB_PORT; do \n\
  sleep 1 \n\
done \n\
echo "MySQL started" \n\
\n\
echo "Running migrations..." \n\
python manage.py migrate --noinput \n\
\n\
echo "Collecting static files..." \n\
python manage.py collectstatic --noinput \n\
\n\
echo "Starting Gunicorn..." \n\
exec gunicorn LearningAWS.wsgi:application --bind 0.0.0.0:8000 --workers 3 --access-logfile - --error-logfile - \n\
' > /app/entrypoint.sh && chmod +x /app/entrypoint.sh

# Run entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]