from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

lisalistener = Blueprint('listalistener', __name__)

# POST new playlist to the DB 
@lisalistener.route('/playlists', methods=['POST']) 
def add_new_playlist(): 
    
    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variable 
    playlist_name = the_data['playlist_name']
    likes = the_data['likes']
    date_made = the_data['date_made']
    duration = the_data['duration']
    episode_number = the_data['episode_number1']
    user_id = the_data['user_id']

    # constructing the query 
    query = 'insert into Playlists (playlist_name,likes,date_made,duration,episode_number,user_id) values ("'
    query+= playlist_name + '", '
    query+= str(likes) + ', "'
    query+= date_made + '", '
    query+= str(duration) + ', '
    query+= str(episode_number) + ', '
    query+= str(user_id) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db().commit()

    return 'Success!'

# PUT (update) episode info in a playlist 
@lisalistener.route('/playlists/<episode_number>', methods=['PUT']) 
def update_episode_in_playlist(episode_number): 

    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variables
    playlist_name = the_data['playlist_name2']
    likes = the_data['likes2']
    date_made = the_data['date_made2']
    duration = the_data['duration_2']
    episode_number = the_data['episode_number2']
    user_id = the_data['user_id2']

    # constructing the query 
    query = 'update Playlists set playlist_name = "' 
    query+= playlist_name + '", likes = '
    query+= str(likes) + ', date_made = "'
    query+= date_made + '", duration = '
    query+= str(duration) + ', episode_number = '
    query+= str(episode_number) + ', playlist_name = '
    query+= str(user_id) + ' where episode_number = '
    query+= str(episode_number) 
    current_app.logger.info(query)

    # executing and committing the put statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db().commit() 

    return 'Success!'

# DELETE episode from playlist 
@lisalistener.route('/playlists/<episode_number>', methods=['DELETE']) 
def delete_episode_from_playlist(episode_number): 
    
    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variables
    episode_number = the_data['episode_number3']

    # constructing the query 
    query = 'delete from Playlists where episode_number = ' 
    query+= str(episode_number) 

    # executing and committing the delete statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db().commit() 

    return 'Success!'

# GET an episode from a playlist with particular episode number from the DB
@lisalistener.route('/playlists/<episode_number>', methods=['GET'])
def get_episode(episode_number):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Episodes where episode_number = {0}'.format(episode_number))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# GET a creator's info with particular creator id from the DB
@lisalistener.route('/creators/<creator_id>', methods=['GET'])
def get_creator(creator_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Creators where creator_id = {0}'.format(creator_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# GET a playlist's info with a particular user id from the DB
@lisalistener.route('/playlists/<user_id>', methods=['GET'])
def get_playlist(user_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from playlists where user_id = {0}'.format(user_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# DELETE a playlist from the DB with the given date made
@lisalistener.route('/playlists/deleteplaylist/<date_made>', methods=['DELETE']) 
def delete_playlist(date_made): 
    
    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variables
    date_made = the_data['date_made3']

    # constructing the query 
    query = 'delete from Playlists where date_made = "' 
    query+= date_made + '"'
    # executing and committing the delete statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db().commit() 

    return 'Success!'

# GET a podcasts's info with a particular creator id from the DB
@lisalistener.route('/podcasts/<creator_id>', methods=['GET'])
def get_podcast(creator_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Podcasts where creator_id = {0}'.format(creator_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response