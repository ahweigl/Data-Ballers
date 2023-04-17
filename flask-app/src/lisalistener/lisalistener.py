from flask import Blueprint, request, jsonify, make_response
import json
from src import db


lisalistener = Blueprint('listalistener', __name__)

# Get an episode from a playlist with particular episode number from the DB
@lisalistener.route('/playlists/<episode_number>', methods=['GET'])
def get_episode(episode_number):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Episodes where id = {0}'.format(episode_number))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a creator's info with particular creator id from the DB
@lisalistener.route('/creators/<creator_id>', methods=['GET'])
def get_creator(creator_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from creators where id = {0}'.format(creator_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a playlist's info with particular name from the DB
@lisalistener.route('/playlists/<playlist_name>', methods=['GET'])
def get_playlist(playlist_name):
    cursor = db.get_db().cursor()
    cursor.execute('select * from playlists where id = {0}'.format(playlist_name))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a podcasts's info with particular name from the DB
@lisalistener.route('/podcasts/<podcast_name>', methods=['GET'])
def get_podcast(podcast_name):
    cursor = db.get_db().cursor()
    cursor.execute('select * from podcasts where id = {0}'.format(podcast_name))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

'''
# Get customer detail for customer with particular userID
@customers.route('/customers/<userID>', methods=['GET'])
def get_customer(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from customers where id = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
    '''