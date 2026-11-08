from flask import Flask, jsonify, render_template
import socket
import datetime

app = Flask(__name__)

@app.route("/")
def home():
    return render_template(
        "index.html",
        hostname=socket.gethostname(),
        time=datetime.datetime.now().strftime("%d-%m-%Y %H:%M:%S")
    )

@app.route("/health")
def health():
    return jsonify({"status": "UP"}), 200

@app.route("/info")
def info():
    return jsonify({
        "application": "DevOps Automation",
        "environment": "Local Ubuntu",
        "version": "1.0"
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
