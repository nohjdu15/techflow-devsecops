from fastapi import FastAPI
import os

app = FastAPI()


@app.get("/")
def root():
    secret = os.getenv("MY_SECRET", "")
    return {"message": "Hola Mundo", "secret": secret}


@app.get("/health")
def health():
    return {"status": "ok"}
