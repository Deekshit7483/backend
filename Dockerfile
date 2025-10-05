FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /code

# system deps
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY django_backend/requirements.txt /code/requirements.txt
RUN pip install --upgrade pip && pip install -r /code/requirements.txt

COPY django_backend /code

COPY django_backend/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PORT=8000
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
