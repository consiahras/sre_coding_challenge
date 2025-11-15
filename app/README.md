# Simple Python Web Application

This directory contains a minimal Python Flask web application designed for the SRE coding challenge. The app responds with "Hello world" to HTTP requests on port 8080.

## Application Code

- **Source:** `src/app.py`  
  A simple Flask server exposing a single endpoint (`/`) that returns "Hello world". The app is configured to listen on all network interfaces (`0.0.0.0`) on port 8080.

## Dependencies

- Specified in `requirements.txt`:
  - `flask==2.3.2` — lightweight web framework

## Dockerfile

The `Dockerfile` builds a small container image based on the official `python:3.11-slim` image:

- Sets working directory to `/app`
- Copies and installs Python dependencies
- Copies application source code
- Exposes port 8080
- Runs the Flask app with specified host and port

## Building and Running Locally

To build the Docker image locally:

cd app/
docker build -t sre_challenge_app:v1.0.0 .

docker image ls
REPOSITORY TAG IMAGE ID CREATED SIZE
sre_challenge_app v1.0.0 27a6ef76ccb1 2 seconds ago 140MB

## To run the application container locally:

docker run -p 8080:8080 sre_challenge_app:v1.0.0

```
docker run -p 8080:8080 sre_challenge_app:v1.0.0
 * Serving Flask app 'src/app.py'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8080
 * Running on http://172.17.0.2:8080
Press CTRL+C to quit
172.17.0.1 - - [15/Nov/2025 07:41:45] "GET / HTTP/1.1" 200 -            <--- successful request from broswer>
```

Then navigate to `http://localhost:8080` in your browser or use `curl` to see the "cool response".

## Notes

- This app and Dockerfile are minimal and intended as a demonstration for containerization and CI build processes.
- The port 8080 was chosen to meet the challenge requirement.
- Flask's built-in development server is used for simplicity; in production, a more robust server is recommended.
