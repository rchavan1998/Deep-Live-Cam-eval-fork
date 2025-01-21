# Use Python 3.10 as the base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    python3-tk \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python build tools
RUN pip install --upgrade pip setuptools wheel

# Set the working directory
WORKDIR /app

# Copy the repository code into the container
COPY . /app

# Install Python dependencies
RUN pip install -r requirements.txt || pip install numpy opencv-python torch torchvision onnxruntime

# Default command to start the application
CMD ["python", "run.py"]
