# STAGE 1: Builder
FROM python:3.10-slim as builder

WORKDIR /app
COPY app/requirements.txt .

RUN pip install --no-cache-dir --target=/app/dependencies -r requirements.txt

# STAGE 2: Runtime
FROM python:3.10-slim

RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

COPY --from=builder /app/dependencies /usr/local/lib/python3.10/site-packages/

COPY app/ .

USER appuser

EXPOSE 8000


CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
