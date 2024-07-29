# Use the official Python image based on Debian
FROM python:3.11-slim-buster

# Download and install ttyd binary
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
    
# Create a non-root user and switch to it (for security)
RUN useradd -ms /bin/bash appuser
USER appuser
WORKDIR /home/appuser/app

# Copy requirements.txt first (for efficient caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your Python script 
COPY script.py .
COPY keep_alive.py .

# Expose the port
EXPOSE 80

# Use a more efficient CMD to start ttyd and the script
CMD ["python3", "script.py"]
