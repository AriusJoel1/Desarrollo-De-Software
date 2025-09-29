# app.py
import os
import time
import json
from datetime import datetime
from flask import Flask, jsonify, request

app = Flask(__name__)

# Configuración leída al arranque (simula comportamiento "requiere reinicio para cambios de env")
PORT = int(os.getenv("PORT", "8080"))
MESSAGE = os.getenv("MESSAGE", "Hola CC3S2")
RELEASE = os.getenv("RELEASE", "v1")

def log_json(level, msg, **extra):
    entry = {
        "ts": datetime.utcnow().isoformat()+"Z",
        "level": level,
        "msg": msg,
    }
    entry.update(extra)
    print(json.dumps(entry), flush=True)  # stdout (12-Factor)

@app.route("/", methods=["GET"])
def index():
    log_json("INFO", "request", path=request.path, remote=request.remote_addr)
    return jsonify({"message": MESSAGE, "release": RELEASE})

if __name__ == "__main__":
    log_json("INFO", "starting", port=PORT, release=RELEASE)
    app.run(host="0.0.0.0", port=PORT)
