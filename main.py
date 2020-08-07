from flask import Flask
from services.pageroute import page


app = Flask(__name__)
app.register_blueprint(page, url_prefix='/')

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=3000)