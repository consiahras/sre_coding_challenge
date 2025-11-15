# Use official Python slim as base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app source code
COPY src/ ./src

# Set environment variable for Flask app
ENV FLASK_APP=src/app.py

# Expose port 8080
EXPOSE 8080

# Run the app
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=8080"]
