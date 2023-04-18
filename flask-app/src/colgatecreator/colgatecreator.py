from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


colgatecreator = Blueprint('colgatecreator', __name__)

# POST new episode to the DB  
@colgatecreator.route('/episodes', methods=['POST']) 
def add_new_episode(): 
    
    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variable 
    episode_number = the_data['episode_number']
    duration = the_data['duration']
    listens = the_data['listens']
    season_number = the_data['season_number']
    episode_name = the_data['episode_name']
    podcast_name = the_data['podcast_name']
    playlist_name = the_data['playlist_name']

    # constructing the query 
    query = 'insert into Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) values ("'
    query+= str(episode_number) + '", '
    query+= str(duration) + ', '
    query+= str(listens) + ', '
    query+= str(season_number) + ', "'
    query+= episode_name + '", "'
    query+= podcast_name + '", "'
    query+= playlist_name + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db().commit()

    return 'Success!'

# GET inventory information from the DB 
# Get all customers from the DB
@colgatecreator.route('/inventory', methods=['GET'])
def get_inventory():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Inventory')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# DELETE an episode from the DB 
# TO DO 

# GET statistics about a particular creator 
# GET a creator's info with particular creator id from the DB
@colgatecreator.route('/statistics/<creator_id>', methods=['GET'])
def get_statistics(creator_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Statistics where creator_id = {0}'.format(creator_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# GET a supplier's info with the particular supplier id
@colgatecreator.route('/suppliers/<supplier_id>', methods=['GET'])
def get_supplier(supplier_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Suppliers where supplier_id = {0}'.format(supplier_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# POST new inventory 
@colgatecreator.route('/inventory', methods=['POST']) 
def add_inventory(): 
    
    # collecting data from the request object 
    the_data = request.json 
    current_app.logger.info(the_data) 

    # extracting the variable 
    total_in_stock = the_data['total_in_stock']
    item_number = the_data['item_number']
    available_sizes = the_data['available_sizes']
    date_last_restock = the_data['date_last_restock']
    date_next_restock = the_data['date_next_restock']
    
    # constructing the query 
    query = 'insert into Inventory (total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) values ('
    query+= str(total_in_stock) + ', '
    query+= str(item_number) + ', "'
    query+= available_sizes + '", "'
    query+= date_last_restock + '", "'
    query+= date_next_restock + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor() 
    cursor.execute(query) 
    db.get_db().commit()

    return 'Success!'

# GET merchandise info from the DB 
@colgatecreator.route('/merchandise', methods=['GET'])
def get_merchandise():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Merchandise')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# PUT new order into the DB 
# TO DO 