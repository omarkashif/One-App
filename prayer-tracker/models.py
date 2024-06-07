from app import db

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

class Prayers(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class PrayerStatus(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    prayer_id = db.Column(db.Integer, db.ForeignKey('prayers.id'), nullable=False)
    status = db.Column(db.Boolean, nullable=False)
    date = db.Column(db.Date, nullable=False)

    user = db.relationship('User', backref=db.backref('prayer_status', lazy=True))
    prayer = db.relationship('Prayers', backref=db.backref('prayer_status', lazy=True))
