FROM python:3.10-slim
RUN apt-get update && apt-get install -y procps libgomp1 && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir scanpy squidpy matplotlib pandas anndata
WORKDIR /pipeline
