from flask import Flask
from threading import Thread
import os

app = Flask('')

@app.route('/')
def home():
    return os.environ.get('EMAIL', 'I am alive!')

def run():
    port = int(os.environ.get('PORT', 80))
    app.run(host='0.0.0.0', port=80)

def keep_alive():
    t = Thread(target=run)
    t.start()
