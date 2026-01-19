import time
import random
import os
from fastapi import FastAPI, Response, status
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()

Instrumentator().instrument(app).expose(app)

@app.get("/health")
def health_check():
    return {"status": "healthy", "version": os.getenv("APP_VERSION", "v0.0.1")}

@app.get("/")
def read_root():
    return {"message": "Production-Grade DevOps Project"}

@app.get("/simulate-error")
def simulate_error(response: Response):
    if random.random() < 0.3:
        response.status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
        return {"error": "Simulated Internal Server Error"}
    return {"message": "Success"}

@app.get("/simulate-latency")
def simulate_latency():
    delay = random.uniform(0.5, 2.0)
    time.sleep(delay)
    return {"message": f"Responded after {delay:.2f} seconds"}
