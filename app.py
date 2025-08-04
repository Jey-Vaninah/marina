from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route("/marina", methods=["POST"])
def run_marina():
    data = request.get_json()
    if not data or "laza" not in data:
        return jsonify({"error": "Missing 'laza' in request body"}), 400

    laza = data["laza"]
    try:
        result = subprocess.check_output(["./marina", laza], stderr=subprocess.STDOUT)
        return jsonify({"result": result.decode().strip()})
    except subprocess.CalledProcessError as e:
        return jsonify({"error": e.output.decode()}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
