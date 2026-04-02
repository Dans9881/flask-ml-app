FROM python:3.8-slim

WORKDIR /app

# System deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Install deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir gdown

# Copy source dulu (biar folder static/model ada)
COPY . .

# Download model ke path lama
RUN mkdir -p /app/static/model && \
    cd /app/static/model && \
    gdown --id 1L7YPV3SLl08X6otuV1epolnwh1tGNEsq && \
    gdown --id 1RgNc29CR98pcg3krGxA784Zxv2xx93pQ

ENV PYTHONUNBUFFERED=1

CMD ["python", "app.py"]