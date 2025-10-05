#!/bin/bash
set -e

# Run migrations and collectstatic (if any)
python manage.py migrate --noinput

# Start Gunicorn
exec gunicorn backend.wsgi:application --bind 0.0.0.0:${PORT} --workers 3
