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
    name = the_data['name']
    likes = the_data['likes']
    date_made = the_data['date_made']
    duration = the_data['duration']
    episode_number = the_data['episode_number']
    playlist_name = the_data['playlist_name']
    user_id = the_data['user_id']

    # constructing the query 
    query = 'insert into Playlists (name,likes,date_made,duration,episode_number,playlist_name,user_id) values ("'
    query+= name + '", '
    query+= str(likes) + ', "'
    query+= date_made + '", '
    query+= str(duration) + ', '
    query+= str(episode_number) + ', "'
    query+= playlist_name + '", '
    query+= str(user_id) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db().commit()

    return 'Success!'

# PUT episode info into playlists (update an episode in a playlist)
# TO DO 
@lisalistener.route('/playlists', methods=['PUT']) 
def update_episode(): 
    
    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variables
    episode_number = the_data['episode_number']
    duration = the_data['duration']
    listens = the_data['listens']
    season_number = the_data['season_number']
    episode_name = the_data['episode_name']
    podcast_name = the_data['podcast_name']
    playlist_name = the_data['playlist_name']

    # constructing the query 
    query = 'update Playlists set episode_number = ' 
    query+= str(episode_number) + '", duration = '
    query+= str(duration) + '", listens = '
    query+= str(listens) + '", season_number'
    query+= str(season_number) + '", episode_name = "'
    query+= episode_name + '", podcast_name = "'
    query+= podcast_name + '", playlist_name = "'
    query+= playlist_name + ' where '
    # FIX HERE query+= str(episode_number) + {0}'.format(episode_number)

    # executing and committing the put statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db.commit() 

    return 'Success!'

# DELETE episode from playlist 
# TO DO 
@lisalistener.route('/playlists', methods=['DELETE']) 
def delete_episode(): 
    
    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variables
    episode_number = the_data['episode_number']

    # constructing the query 
    query = 'delete from Playlists where episode_number = ' 
    query+= str(episode_number) + ')'

    # executing and committing the put statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db.commit() 

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

# DELETE a playlist from the DB 
# TO DO 
@lisalistener.route('/playlists', methods=['DELETE']) 
def delete_playlist(): 
    
    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variables
    name = the_data['name']

    # constructing the query 
    query = 'delete from Playlists where name = ' 
    query+= name + ')'

    # executing and committing the put statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db.commit() 

    return 'Success!'

# GET a podcasts's info with particular name from the DB
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