from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object('config.Config')
db = SQLAlchemy(app)

from models import User, Prayers, PrayerStatus
from routes import *

if __name__ == '__main__':
    app.run(debug=True)
