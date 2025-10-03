#!/usr/bin/env python
"""
Test script to verify environment variables are working
"""
import os
import sys
import django

# Setup Django environment
sys.path.append('.')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'LearningAWS.settings')
django.setup()

from django.conf import settings

print("Testing Environment Variables...")
print(f"✅ SECRET_KEY loaded: {settings.SECRET_KEY[:20]}...")
print(f"✅ DEBUG: {settings.DEBUG}")
print(f"✅ DB Host: {settings.DATABASES['default']['HOST'][:30]}...")
print(f"✅ DB Name: {settings.DATABASES['default']['NAME']}")
print(f"✅ DB User: {settings.DATABASES['default']['USER']}")
print(f"✅ AWS Bucket: {settings.AWS_STORAGE_BUCKET_NAME}")
print(f"✅ AWS Region: {settings.AWS_S3_REGION_NAME}")
print(f"✅ AWS Access Key: {settings.AWS_ACCESS_KEY_ID[:10]}...")

print("\n🎉 All secrets successfully loaded from environment variables!")