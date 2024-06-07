from flask import request, jsonify
from app import app, db
from models import User, Prayers, PrayerStatus
from datetime import date

@app.route('/get-prayers', methods=['GET'])
def get_prayers():
    user_id = request.args.get('user_id')
    today = date.today()
    prayer_statuses = PrayerStatus.query.filter_by(user_id=user_id, date=today).all()
    result = []
    for ps in prayer_statuses:
        prayer = Prayers.query.get(ps.prayer_id)
        result.append({
            'prayer': prayer.name,
            'status': ps.status
        })
    return jsonify(result)

@app.route('/save-prayer', methods=['POST'])
def save_prayer():
    data = request.get_json()
    user_id = data['user_id']
    prayer_id = data['prayer_id']
    status = data['status']
    today = date.today()
    
    prayer_status = PrayerStatus.query.filter_by(user_id=user_id, prayer_id=prayer_id, date=today).first()
    if prayer_status:
        prayer_status.status = status
    else:
        prayer_status = PrayerStatus(user_id=user_id, prayer_id=prayer_id, status=status, date=today)
        db.session.add(prayer_status)
    db.session.commit()
    return jsonify({'message': 'Prayer status updated successfully'})
    