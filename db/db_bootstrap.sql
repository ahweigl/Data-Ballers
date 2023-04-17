-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database Podify;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on Podify.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use Podify;

-- Put your DDL 
--CREATE TABLE test_table (
--  name VARCHAR(20),
 -- color VARCHAR(10)
--);


-- Add sample data. 
--INSERT INTO test_table
 -- (name, color)
--VALUES
 -- ('dev', 'blue'),
  --('pro', 'yellow'),
 -- ('junior', 'red');
--# Administrators table

CREATE TABLE Administrators
(
    email_address varchar(50) NOT NULL,
    phone_number varchar(20) NOT NULL,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    admin_id int PRIMARY KEY,
    CONSTRAINT fk_1
        FOREIGN KEY (admin_id) REFERENCES Users(user_id)
);

--# Insert data into Administrators table
INSERT INTO Administrators
    VALUES ('weigl.a@northeastern.edu', '123-456-7890', 'Angela', 'Weigl', '1');
INSERT INTO Administrators
    VALUES ('costa.n@northeastern.edu', '098-765-4321', 'Natalie', 'Costa', '2');

--# Genre table
CREATE TABLE Genre
(
    number_of_shows int,
    number_of_playlists int,
    podcast_name varchar(50) NOT NULL,
    genre_name varchar(50) PRIMARY KEY
);

--#Insert data into Genre table
INSERT INTO Genre
    VALUES (10, 20, 'very cool podcast', 'comedy');
INSERT INTO Genre
    VALUES (15, 25, 'very cool podcast the sequel', 'horror');

--# Podcasts table
CREATE TABLE Podcasts
(
    release_date datetime
        DEFAULT CURRENT_TIMESTAMP,
    number_of_episodes int NOT NULL,
    genre_name varchar(50),
    episode_number int NOT NULL,
    creator_id int NOT NULL,
    name varchar(50) PRIMARY KEY,
    CONSTRAINT fk_2
        FOREIGN KEY (genre_name) REFERENCES Genre(genre_name),
    CONSTRAINT fk_3
        FOREIGN KEY (creator_id) REFERENCES Creators(creator_id),
    CONSTRAINT fk_6
        FOREIGN KEY (episode_number) REFERENCES Episodes(episode_number)
);

--# Insert data into podcasts table
INSERT INTO Podcasts
    VALUES(CURRENT_TIMESTAMP, 10, 'comedy', 1, 1, 'very epic podcast');
INSERT INTO Podcasts
    VALUES(CURRENT_TIMESTAMP, 12, 'comedy', 1, 2, 'very epic podcast 2');

--# Playlists table
CREATE TABLE Playlists
(
    likes int NOT NULL,
    date_made datetime
        DEFAULT CURRENT_TIMESTAMP,
    duration int NOT NULL,
    episode_number int NOT NULL,
    playlist_name varchar(50) NOT NULL,
    user_id int NOT NULL,
    name varchar(50) PRIMARY KEY,
    CONSTRAINT fk_4
        FOREIGN KEY (episode_number) REFERENCES Episodes (episode_number),
    CONSTRAINT fk_12
        FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

--# Insert data into Playlists table
INSERT INTO Playlists
    VALUES (10, CURRENT_TIMESTAMP, 45, 1, 'playlist', 1, 'epic playlist');
INSERT INTO Playlists
    VALUES (18, CURRENT_TIMESTAMP, 50, 3, 'playlist', 1, 'epic playlist 3');

--# Episodes table
CREATE TABLE Episodes
(
    duration int NOT NULL,
    listens int  NOT NULL,
    season_number int NOT NULL,
    episode_name varchar(50) NOT NULL,
    podcast_name varchar(50) NOT NULL,
    playlist_name varchar(50) NOT NULL,
    episode_number int PRIMARY KEY
);

--# Insert data into Episodes table
INSERT INTO Episodes
    VALUES (60, 1234, 1, 10, 'very cool podcast', 'epic playlist', 1);
INSERT INTO Episodes
    VALUES (99, 86343, 2, 12, 'very cool podcast the sequel', 'epic playlist', 3);

--# Users table
CREATE TABLE Users
(
    username varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    date_made datetime
        DEFAULT CURRENT_TIMESTAMP,
    phone_number varchar(20) NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    card_number int,
    cvv int,
    expiration_date varchar(50),
    street varchar(50),
    city varchar(50),
    state varchar(50),
    zip_code int,
    user_id int PRIMARY KEY
);

--# Insert data into Users table
INSERT INTO Users
    VALUES ('ahweigl', 'password', CURRENT_TIMESTAMP, '123-456-7890', 'Angela', 'Weigl', '123', '123', '06/2024',
            'Street', 'City', 'Colorado', '80122', '1');
INSERT INTO Users
    VALUES ('nmcost', 'password', CURRENT_TIMESTAMP, '098-765-4321', 'Natalie', 'Costa', '123', '123', '08/2025',
            'Street', 'City', 'Maryland', '12345', '2');

--# Statistics table
CREATE TABLE Statistics
(
    total_listens int NOT NULL,
    total_likes int NOT NULL,
    total_followers int NOT NULL,
    total_episodes int NOT NULL,
    creator_id int PRIMARY KEY,
     CONSTRAINT fk_7
        FOREIGN KEY (creator_id) REFERENCES Creators (creator_id)
);

--# Insert data into Statistics table
INSERT INTO Statistics
    VALUES (1000, 1234, 12440, 30, 1);
INSERT INTO Statistics
    VALUES (1456, 986, 435987, 38, 2);

--# Creators table
CREATE TABLE Creators
(
    username varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    date_made datetime
        DEFAULT CURRENT_TIMESTAMP,
    phone_number varchar(20) NOT NULL,
    email_address varchar(50) NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    card_number int,
    cvv int,
    expiration_date varchar(50),
    street varchar(50),
    city varchar(50),
    state varchar(50),
    zip_code int,
    creator_id int PRIMARY KEY
);

--# Insert data into Creators table
INSERT INTO Creators
    VALUES('vickiwong', 'password', CURRENT_TIMESTAMP, '123-444-5555', 'wong.v@northeasternedu', 'Vicki',
           'Wong', '111', '222', '04/2029', 'Streetname', 'Cityname', 'Statename', '12345', 1);
INSERT INTO Creators
    VALUES('rayv', 'password', CURRENT_TIMESTAMP, '888-888-8888', 'valenzuela.r@northeasternedu', 'Ray',
           'Valenzuela', '222', '333', '02/2025', 'Streetname', 'Cityname', 'Statename', '12345', 2);

--# Merchandise table
CREATE TABLE Merchandise
(
    creator_id int NOT NULL,
    item_description varchar(100) NOT NULL,
    total_in_stock int NOT NULL,
    available_sizes varchar(50) NOT NULL,
    date_last_restock datetime,
    date_next_restock datetime,
    supplier_id int NOT NULL,
    supplier_state varchar(50) NOT NULL,
    supplier_street varchar(50) NOT NULL,
    supplier_city varchar(50) NOT NULL,
    supplier_zip_code int NOT NULL,
    item_number int PRIMARY KEY,
    CONSTRAINT fk_8
        FOREIGN KEY (creator_id) REFERENCES Creators (creator_id),
    CONSTRAINT fk_9
        FOREIGN KEY (total_in_stock) REFERENCES Inventory(total_in_stock),
    CONSTRAINT fk_10
        FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

--# Insert data into merchandise table
INSERT INTO Merchandise
    VALUES (1, 'cool shirt', 1000, 'XS, S, M, L', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 'state', 'street',
            'city', 12345, 1);
INSERT INTO Merchandise
    VALUES (2, 'cool pants', 1000, 'XS, S, M, L', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, 'state', 'street',
            'city', 77777, 2);

--# Inventory table
CREATE TABLE Inventory (
    item_number int NOT NULL,
    available_sizes varchar(50) NOT NULL,
    date_last_restock datetime NOT NULL,
    date_next_restock datetime NOT NULL,
    total_in_stock int PRIMARY KEY
);

--# Insert data into inventory table
INSERT INTO Inventory
    VALUES (1, 'XS, S, M', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1000);
INSERT INTO Inventory
    VALUES (2, 'XS, S, M', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 200);

--# Orders table
CREATE TABLE Orders
(
    price int NOT NULL,
    customer_name varchar(50) NOT NULL,
    item_number int NOT NULL,
    order_number int PRIMARY KEY,
    CONSTRAINT fk_11
        FOREIGN KEY (item_number) REFERENCES Merchandise (item_number)
);

--# Insert data into Orders
INSERT INTO Orders
    Values (25, 'customer', 1, 1);
INSERT INTO Orders
    Values (30, 'customer', 2, 2);

--# Suppliers table
CREATE TABLE Suppliers
(
    item_number int NOT NULL,
    street varchar(50),
    city varchar(50),
    state varchar(50),
    zip_code int,
    supplier_id int PRIMARY KEY
);

--# Insert data into Suppliers table
INSERT INTO Suppliers
    Values (1, 'street', 'city', 'state', 12345, 1);
INSERT INTO Suppliers
    Values (2, 'street', 'city', 'state', 99999, 2);

--# Data generated using Mockaroo

--# Administrators
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('63', 'hgarrod0@nsw.gov.au', '271-722-4526', 'Heloise', 'Garrod');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('58', 'rerskine1@columbia.edu', '999-984-1235', 'Ruby', 'Erskine');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('13', 'kgoldsby2@pbs.org', '381-936-1810', 'Kesley', 'Goldsby');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('14', 'rmcvanamy3@smh.com.au', '880-349-4079', 'Raine', 'McVanamy');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('60', 'mnorthen4@mozilla.com', '815-217-5094', 'Malinde', 'Northen');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('7', 'kosmon5@wordpress.com', '853-326-8607', 'Kat', 'Osmon');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('48', 'hbellas6@ibm.com', '192-656-8316', 'Hyacinth', 'Bellas');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('3', 'gharriott7@friendfeed.com', '861-454-1562', 'Gilemette', 'Harriott');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('24', 'tlindenfeld8@example.com', '474-438-2409', 'Timothea', 'Lindenfeld');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('6', 'tmcrorie9@livejournal.com', '207-349-5012', 'Thalia', 'McRorie');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('14', 'rdudeniea@rediff.com', '284-237-3716', 'Ruthy', 'Dudenie');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('10', 'rlapishb@nymag.com', '200-935-0539', 'Retha', 'Lapish');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('68', 'gjeunec@springer.com', '229-427-3945', 'Grethel', 'Jeune');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('49', 'smakind@arstechnica.com', '908-708-3264', 'Salomon', 'Makin');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('84', 'fpeirpointe@theatlantic.com', '109-986-2027', 'Frank', 'Peirpoint');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('6', 'ddymondf@sfgate.com', '115-748-5999', 'Douglass', 'Dymond');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('14', 'bmacgahyg@examiner.com', '973-997-8878', 'Blanca', 'MacGahy');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('73', 'tbaintonh@friendfeed.com', '507-314-7405', 'Tobey', 'Bainton');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('2', 'psticklesi@issuu.com', '163-547-0467', 'Patti', 'Stickles');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('33', 'csimeonej@github.com', '929-937-4521', 'Clementina', 'Simeone');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('37', 'soultramk@yale.edu', '570-975-6493', 'Sindee', 'Oultram');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('82', 'jstoadel@bigcartel.com', '561-988-0917', 'Johanna', 'Stoade');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('73', 'fdodimeadm@sina.com.cn', '268-358-2846', 'Franciska', 'Dodimead');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('99', 'rjollandn@sciencedirect.com', '267-862-2844', 'Rickey', 'Jolland');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('80', 'jsemkeno@google.it', '178-865-1635', 'Joly', 'Semken');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('82', 'afleetp@taobao.com', '531-473-9323', 'Augusta', 'Fleet');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('21', 'cduggonq@cdbaby.com', '962-694-1404', 'Camala', 'Duggon');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('1', 'crufflesr@w3.org', '462-766-6663', 'Clerc', 'Ruffles');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('90', 'jwynetts@issuu.com', '826-475-3492', 'Jamesy', 'Wynett');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('58', 'tdonativot@columbia.edu', '107-840-4408', 'Thea', 'Donativo');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('96', 'ofennicku@businessinsider.com', '665-952-5282', 'Obed', 'Fennick');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('2', 'aeveringhamv@arstechnica.com', '808-996-4897', 'Ania', 'Everingham');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('5', 'hchattellw@oaic.gov.au', '534-209-2628', 'Harriott', 'Chattell');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('30', 'bfulcherx@booking.com', '740-106-7386', 'Benedikta', 'Fulcher');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('43', 'nscriveny@ow.ly', '314-568-0141', 'Nichols', 'Scriven');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('42', 'bgoffordz@howstuffworks.com', '383-121-1124', 'Biddie', 'Gofford');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('70', 'erawle10@usa.gov', '399-739-5512', 'Everett', 'Rawle');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('69', 'ltassell11@reddit.com', '498-713-6706', 'Lemmie', 'Tassell');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('28', 'arickaert12@google.com', '148-873-8069', 'Adara', 'Rickaert');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('17', 'sderoos13@de.vu', '950-846-8695', 'Sheba', 'De Roos');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('98', 'bbuddles14@weibo.com', '474-221-2625', 'Berty', 'Buddles');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('57', 'ptuffell15@privacy.gov.au', '380-765-7744', 'Pollyanna', 'Tuffell');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('88', 'emaccambridge16@wix.com', '724-955-2218', 'Ernest', 'MacCambridge');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('30', 'jlevene17@ocn.ne.jp', '276-490-4051', 'Jerome', 'Levene');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('92', 'cshewry18@ted.com', '336-184-5442', 'Caryl', 'Shewry');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('15', 'epostlewhite19@pbs.org', '425-104-3768', 'Elisha', 'Postlewhite');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('8', 'cpatching1a@wunderground.com', '131-501-4338', 'Chloette', 'Patching');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('38', 'tcraigmile1b@seattletimes.com', '931-657-2248', 'Torey', 'Craigmile');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('64', 'icordeiro1c@fda.gov', '189-195-1621', 'Iris', 'Cordeiro');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('54', 'pmallock1d@homestead.com', '667-480-4801', 'Pen', 'Mallock');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('40', 'rdalessandro1e@guardian.co.uk', '494-654-4747', 'Rhianna', 'Alessandro');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('68', 'mmottram1f@usgs.gov', '273-914-3570', 'Melonie', 'Mottram');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('27', 'ebeeze1g@linkedin.com', '709-424-4876', 'Erskine', 'Beeze');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('48', 'dkroch1h@marriott.com', '365-255-5722', 'Darsey', 'Kroch');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('60', 'dcurreen1i@netvibes.com', '712-490-1829', 'Danielle', 'Curreen');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('58', 'krolinson1j@cdc.gov', '721-865-8509', 'Kenon', 'Rolinson');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('15', 'amacken1k@dmoz.org', '573-158-5754', 'Abbe', 'Macken');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('40', 'bchidgey1l@sciencedirect.com', '630-981-1721', 'Brnaby', 'Chidgey');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('90', 'mbisacre1m@springer.com', '767-637-4582', 'Mariska', 'Bisacre');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('84', 'kpechell1n@google.ru', '606-504-9682', 'Kathryne', 'Pechell');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('16', 'rcorbin1o@amazon.co.uk', '635-956-4538', 'Red', 'Corbin');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('93', 'wdungate1p@hao123.com', '948-826-1439', 'Wynn', 'Dungate');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('31', 'lfoulcher1q@vk.com', '755-342-3059', 'Lucine', 'Foulcher');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('56', 'erotter1r@washingtonpost.com', '663-104-0561', 'Esme', 'Rotter');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('48', 'wrembrandt1s@jimdo.com', '129-893-7643', 'Wanda', 'Rembrandt');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('48', 'zchrispin1t@reuters.com', '234-181-9188', 'Zack', 'Chrispin');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('19', 'scamellini1u@uol.com.br', '773-889-0302', 'Smith', 'Camellini');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('84', 'darboine1v@sohu.com', '729-709-8557', 'Demott', 'Arboine');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('51', 'tcourt1w@mozilla.org', '332-352-1964', 'Tate', 'Court');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('72', 'rcaselli1x@sakura.ne.jp', '339-615-7371', 'Rufus', 'Caselli');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('93', 'blongworth1y@miibeian.gov.cn', '412-611-8505', 'Basilius', 'Longworth');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('75', 'mborn1z@feedburner.com', '251-500-1423', 'Minna', 'Born');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('47', 'cfeast20@cam.ac.uk', '823-884-0156', 'Courtnay', 'Feast');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('17', 'mtremethack21@surveymonkey.com', '779-464-8270', 'Madelaine', 'Tremethack');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('14', 'mcalleja22@miibeian.gov.cn', '174-867-4822', 'Mandie', 'Calleja');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('50', 'jkerner23@networksolutions.com', '225-431-5185', 'Jayme', 'Kerner');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('28', 'jpinfold24@live.com', '729-734-7214', 'Jesse', 'Pinfold');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('2', 'nmcmurthy25@bbc.co.uk', '177-846-5181', 'Noby', 'McMurthy');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('13', 'odaughtry26@vk.com', '857-102-8445', 'Oliver', 'Daughtry');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('32', 'amayhead27@pcworld.com', '263-537-8433', 'Ahmad', 'Mayhead');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('19', 'gdeclerq28@mozilla.com', '739-465-6302', 'Garfield', 'de Clerq');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('76', 'djaffa29@usda.gov', '625-192-0744', 'Doralyn', 'Jaffa');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('18', 'akitchingham2a@chron.com', '967-385-0017', 'Antonino', 'Kitchingham');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('7', 'aelijah2b@booking.com', '100-738-8815', 'Anneliese', 'Elijah');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('92', 'jhemmingway2c@baidu.com', '373-723-2223', 'Joycelin', 'Hemmingway');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('61', 'ebounds2d@google.de', '807-987-3229', 'Emmery', 'Bounds');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('67', 'tdmiterko2e@examiner.com', '157-974-2465', 'Tull', 'Dmiterko');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('94', 'rwallen2f@mysql.com', '838-521-7402', 'Russ', 'Wallen');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('35', 'wjacques2g@hc360.com', '669-728-5560', 'Wolf', 'Jacques');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('80', 'lbleue2h@liveinternet.ru', '781-745-1405', 'Lawrence', 'Bleue');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('80', 'cslade2i@alibaba.com', '649-381-6700', 'Christian', 'Slade');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('39', 'mtrice2j@t-online.de', '920-883-8329', 'Marieann', 'Trice');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('5', 'zoldland2k@imageshack.us', '540-308-1342', 'Zelda', 'Oldland');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('43', 'twakerley2l@freewebs.com', '207-273-5241', 'Trever', 'Wakerley');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('100', 'emoret2m@loc.gov', '180-843-9485', 'Elyn', 'Moret');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('57', 'lmanneville2n@tinyurl.com', '666-479-4048', 'Lynette', 'Manneville');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('92', 'maugustine2o@zimbio.com', '801-273-5701', 'Maggi', 'Augustine');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('45', 'ftisun2p@goodreads.com', '552-156-6917', 'Fidelia', 'Tisun');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('63', 'ccasolla2q@skype.com', '603-639-0223', 'Caren', 'Casolla');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('55', 'bsmithies2r@facebook.com', '728-434-8392', 'Blithe', 'Smithies');

--# Creators
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('1', 'ronowlan0', 'WQRCKrSQK', '8/12/2022', '215-458-7971', 'rpinckney0@naver.com', 'Lizette', 'Ruby', '3575723003460298', '971', '9/5/2022', 'Straubel', 'Philadelphia', 'Pennsylvania', '19136');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('2', 'bbedow1', 'wwBhYAfm', '1/11/2023', '509-190-5775', 'bcasine1@theatlantic.com', 'Abbie', 'Bonnibelle', '3548009314243613', '597', '7/29/2022', 'Basil', 'Yakima', 'Washington', '98907');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('3', 'mmyott2', 'o1Kef7SV82x', '5/31/2022', '843-865-3961', 'mwallage2@admin.ch', 'Calida', 'Marna', '6304905551315591', '34', '9/11/2022', 'Lindbergh', 'Charleston', 'South Carolina', '29403');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('4', 'rchallener3', 'LhIJ7NVP', '6/10/2022', '617-257-2093', 'rlook3@taobao.com', 'Kandace', 'Rita', '4175008343478636', '577', '8/26/2022', 'Packers', 'Newton', 'Massachusetts', '02458');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('5', 'nbuyers4', '8bqRk3', '6/12/2022', '772-421-4686', 'ncoburn4@blogger.com', 'Martelle', 'Nani', '3584555883989494', '846', '10/23/2022', 'Grover', 'Fort Pierce', 'Florida', '34981');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('6', 'gmenzies5', 'weevjAJXLo4', '4/2/2023', '412-283-6872', 'gflemmich5@kickstarter.com', 'Nelie', 'Gare', '3557873048972484', '665', '3/17/2023', 'Heffernan', 'Pittsburgh', 'Pennsylvania', '15215');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('7', 'aklimushev6', 'fGJWXqA07', '5/15/2022', '734-365-8211', 'akornilov6@nbcnews.com', 'Bobina', 'Alphonso', '3571965276929624', '201', '5/30/2022', 'Gulseth', 'Detroit', 'Michigan', '48206');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('8', 'lhutson7', 'l6m0jd9CCk1', '9/6/2022', '775-207-3600', 'ltrobey7@php.net', 'Alexi', 'Lelia', '5020031283729631315', '220', '1/5/2023', 'Vera', 'Reno', 'Nevada', '89510');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('9', 'smacdonogh8', 'zPfr8fy', '9/7/2022', '937-959-0486', 'sfagge8@pbs.org', 'Ann', 'Susette', '3566204835898790', '327', '12/14/2022', 'Vidon', 'Dayton', 'Ohio', '45454');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('10', 'akeasey9', '9jvS67nA', '1/1/2023', '414-781-5574', 'asilley9@smh.com.au', 'Darelle', 'Allys', '374288758768047', '755', '5/14/2022', 'Arizona', 'Milwaukee', 'Wisconsin', '53220');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('11', 'fkosiadaa', 'PbWDXuxqdAd', '2/14/2023', '719-607-5158', 'fvonhagta@walmart.com', 'Cedric', 'Faunie', '372301465110288', '799', '3/10/2023', 'Hermina', 'Pueblo', 'Colorado', '81015');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('12', 'hsebireb', 'Sg4XB7j5n8g', '6/20/2022', '614-410-5169', 'hgorringeb@weather.com', 'Urbain', 'Hartwell', '4911115048142802', '761', '8/17/2022', 'Gale', 'Columbus', 'Ohio', '43204');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('13', 'mgathc', 'Ku4COfsQOkRq', '3/28/2023', '610-192-3311', 'mparkinc@nationalgeographic.com', 'Tim', 'Manon', '3550920156528439', '346', '3/30/2023', 'Arrowood', 'Reading', 'Pennsylvania', '19610');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('14', 'jpleasaunced', '9kUYryDtX', '7/18/2022', '386-313-8790', 'jdavinetd@tinypic.com', 'Sebastian', 'Justis', '3531364956933057', '819', '4/2/2023', 'Basil', 'Daytona Beach', 'Florida', '32123');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('15', 'amacronalde', '3tt9pQVm', '10/18/2022', '510-619-2128', 'aaspinalle@disqus.com', 'Aldo', 'Alfie', '3528968885663026', '363', '7/18/2022', 'Petterle', 'Richmond', 'California', '94807');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('16', 'ccheleyf', 'er20nfh5XDQP', '8/28/2022', '215-547-7228', 'ccollocottf@vistaprint.com', 'Red', 'Casar', '3584005372874765', '463', '3/2/2023', 'Red Cloud', 'Philadelphia', 'Pennsylvania', '19093');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('17', 'nringsg', '1QhEkRY', '3/17/2023', '313-378-8674', 'nboerderg@reverbnation.com', 'Richart', 'Nikolaus', '3577557515451264', '276', '6/5/2022', 'Fordem', 'Detroit', 'Michigan', '48224');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('18', 'msouzah', 'k2jTwM', '3/14/2023', '414-596-0181', 'mliveingh@chron.com', 'Marge', 'Marieann', '3589981103612184', '800', '9/19/2022', 'Oriole', 'Milwaukee', 'Wisconsin', '53263');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('19', 'jalderwicki', '519ewm', '10/2/2022', '213-748-6251', 'jmcphillipsi@walmart.com', 'Merilee', 'Jasen', '201531217801548', '971', '8/29/2022', 'Graedel', 'Los Angeles', 'California', '90081');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('20', 'bclemontj', 'usJDO19WOB', '10/5/2022', '719-677-9752', 'bwaudbyj@angelfire.com', 'Allene', 'Beilul', '3532145550623106', '573', '11/3/2022', 'Barby', 'Colorado Springs', 'Colorado', '80935');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('21', 'lpoggk', 'NTlP3RfI5', '7/24/2022', '504-765-7916', 'lbielfeldtk@fotki.com', 'Levey', 'Lurlene', '3576470252277846', '867', '2/4/2023', 'Arapahoe', 'New Orleans', 'Louisiana', '70116');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('22', 'sbuyersl', 'VZyapfQD01I', '7/27/2022', '714-799-4053', 'sdudderidgel@cocolog-nifty.com', 'Anabelle', 'Starlin', '4017954960282', '237', '4/3/2023', 'Stone Corner', 'San Jose', 'California', '95128');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('23', 'jsapshedm', 'LqbpwmqZ8', '7/5/2022', '260-704-4273', 'jeasbiem@cnn.com', 'Val', 'Jeno', '3557701623660416', '765', '5/18/2022', 'Esch', 'Fort Wayne', 'Indiana', '46896');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('24', 'kgosnalln', 'zB39Bsxb', '10/26/2022', '714-577-4962', 'knawtonn@bloomberg.com', 'Nadia', 'Keven', '5641829798273476', '147', '5/31/2022', 'Springs', 'Fullerton', 'California', '92835');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('25', 'cbugdello', 'QZkI1hR', '2/5/2023', '813-828-8476', 'ccaddo@yahoo.co.jp', 'North', 'Calvin', '337941872101406', '286', '8/11/2022', 'Bluestem', 'Tampa', 'Florida', '33686');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('26', 'atabertp', 'uszk5E2ufRQ', '11/18/2022', '623-104-1840', 'amcairtp@xing.com', 'Lianna', 'Ava', '3543082186298648', '469', '7/21/2022', 'Waubesa', 'Phoenix', 'Arizona', '85035');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('27', 'ayeabsleyq', 'bPBf8rzTs', '9/28/2022', '864-535-1819', 'akinsetq@sun.com', 'Jania', 'Alexander', '3573049034720019', '695', '4/2/2023', 'Lindbergh', 'Spartanburg', 'South Carolina', '29305');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('28', 'kbeaner', 'SyEDUu', '3/18/2023', '512-389-2669', 'kwarriorr@pagesperso-orange.fr', 'Gardner', 'Kyla', '5602255700261564', '688', '9/21/2022', 'Steensland', 'Austin', 'Texas', '78703');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('29', 'rallins', 'elyxXzCW5v', '10/15/2022', '225-805-9552', 'rjudges@omniture.com', 'Griffy', 'Randie', '374622076848075', '535', '8/10/2022', 'Northwestern', 'Baton Rouge', 'Louisiana', '70820');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('30', 'amiskt', 'QiOZ5FgDRYW', '8/31/2022', '615-509-3632', 'akencottt@tinyurl.com', 'Colver', 'Amii', '30349170309491', '647', '5/8/2022', 'Nevada', 'Nashville', 'Tennessee', '37220');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('31', 'bgathercoalu', '757igIRMc', '12/11/2022', '718-379-0287', 'bspacyu@deviantart.com', 'Gypsy', 'Barbaraanne', '3535971669030306', '460', '3/7/2023', 'Jackson', 'Staten Island', 'New York', '10305');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('32', 'ebescobyv', 'orp5VpebOx', '3/31/2023', '210-993-2346', 'eeadyv@walmart.com', 'Reese', 'Erasmus', '3534124610416809', '404', '9/28/2022', 'Annamark', 'San Antonio', 'Texas', '78210');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('33', 'rtraskw', 'FTJSJtk5q', '6/3/2022', '775-894-0563', 'rpancoustw@is.gd', 'Chrysa', 'Risa', '3550983060770455', '261', '5/29/2022', 'Crest Line', 'Reno', 'Nevada', '89510');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('34', 'ftindallx', 'DLvTNjvB7ns', '3/27/2023', '515-247-0535', 'fbugbirdx@ibm.com', 'Matty', 'Flora', '5108756868585743', '376', '12/28/2022', 'Kropf', 'Des Moines', 'Iowa', '50335');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('35', 'mlissemorey', 'AYi8JPR', '9/30/2022', '956-288-0173', 'msmowtony@networksolutions.com', 'Eartha', 'Mordecai', '58938603075519435', '921', '11/29/2022', 'Rigney', 'Laredo', 'Texas', '78044');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('36', 'astockleyz', 'aErAzmMP', '6/19/2022', '612-419-6931', 'arumboldz@hostgator.com', 'Corbie', 'Adelheid', '337941702302570', '426', '10/27/2022', 'Fallview', 'Minneapolis', 'Minnesota', '55436');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('37', 'sewington10', 'uUcEjSaZi', '11/19/2022', '336-555-2715', 'sodulchonta10@taobao.com', 'Auguste', 'Sawyer', '5602257209433322', '53', '12/8/2022', '2nd', 'Winston Salem', 'North Carolina', '27157');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('38', 'mgilogly11', 'gjISqac8zMS', '3/25/2023', '469-865-7429', 'malsford11@cnn.com', 'Sallie', 'Manfred', '5048373875330700', '484', '1/30/2023', 'Derek', 'Dallas', 'Texas', '75205');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('39', 'egavin12', 'MDu2XyJ5F', '2/22/2023', '916-163-5836', 'eganniclifft12@europa.eu', 'Pierrette', 'Erwin', '3571766247716060', '182', '5/31/2022', 'Dottie', 'Sacramento', 'California', '94263');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('40', 'bhounsham13', 'qvonNaFFxf', '10/1/2022', '304-725-2255', 'bpainter13@gizmodo.com', 'Kennett', 'Brendin', '5523366364267643', '383', '7/14/2022', 'Elgar', 'Charleston', 'West Virginia', '25313');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('41', 'smooney14', 'CbkSIEHFDx1', '10/3/2022', '713-333-5287', 'sgethouse14@disqus.com', 'Rodge', 'Shurlocke', '630472809605414470', '247', '7/5/2022', 'Lien', 'Houston', 'Texas', '77045');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('42', 'dpalser15', 'WzSzQdz', '11/19/2022', '203-319-5345', 'dbratt15@google.de', 'Nowell', 'Dacy', '3583132648395705', '566', '12/26/2022', 'Annamark', 'Bridgeport', 'Connecticut', '06606');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('43', 'ehinstridge16', 'foWeE8', '9/7/2022', '803-925-0240', 'epinckstone16@istockphoto.com', 'Thalia', 'Emogene', '374622133349992', '765', '10/14/2022', 'Arrowood', 'Columbia', 'South Carolina', '29225');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('44', 'smcevon17', '4FSWJQGvq', '4/12/2023', '502-644-5249', 'sjoyce17@printfriendly.com', 'Antonina', 'Seumas', '677100481779837448', '360', '4/27/2022', 'Arkansas', 'Louisville', 'Kentucky', '40210');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('45', 'edowbekin18', 'Nc9oM7nRDbl', '10/18/2022', '205-566-6987', 'efernley18@apache.org', 'Johnna', 'Estrella', '374622907282809', '534', '6/4/2022', 'Acker', 'Birmingham', 'Alabama', '35244');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('46', 'rdilleway19', 'fKck3QNuT8', '6/16/2022', '405-527-6061', 'rbondar19@cmu.edu', 'Yolanda', 'Rodrique', '5558314377698097', '948', '3/5/2023', 'Paget', 'Oklahoma City', 'Oklahoma', '73152');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('47', 'dwastall1a', '59c7orX71e', '2/3/2023', '512-772-9421', 'dboog1a@marriott.com', 'Angeline', 'Dominga', '6759768076133463', '437', '1/30/2023', 'Waubesa', 'Austin', 'Texas', '78783');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('48', 'bgaylord1b', 'sVDdjzSzB', '6/5/2022', '615-762-6770', 'bcorsham1b@list-manage.com', 'Launce', 'Barb', '6763886982860138', '324', '2/15/2023', 'Waxwing', 'Nashville', 'Tennessee', '37210');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('49', 'ahusby1c', 'jnBHSbP', '1/26/2023', '718-596-2436', 'anano1c@bloglines.com', 'Jereme', 'Anthiathia', '3574648959313558', '523', '3/4/2023', '2nd', 'Jamaica', 'New York', '11480');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('50', 'bsamsin1d', 'gKYUU6', '2/6/2023', '440-770-3606', 'bbielfeldt1d@acquirethisname.com', 'Wake', 'Betsey', '4913817930724005', '141', '12/2/2022', 'Buhler', 'Cleveland', 'Ohio', '44125');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('51', 'lburberow1e', 'QVoKRRNx7F', '3/7/2023', '210-374-3877', 'lwilkinson1e@webeden.co.uk', 'Alla', 'Lorianne', '201735134858271', '559', '2/3/2023', 'Jenna', 'San Antonio', 'Texas', '78291');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('52', 'ativnan1f', 'xZzS4FI', '2/11/2023', '775-587-4695', 'afontelles1f@indiatimes.com', 'Ellyn', 'Ara', '6383299708595352', '905', '3/15/2023', 'Armistice', 'Reno', 'Nevada', '89550');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('53', 'vmulrean1g', 'E8Dn22Bu3SCv', '7/3/2022', '915-860-8779', 'vpeck1g@springer.com', 'Boycie', 'Vivien', '201677468644275', '349', '11/22/2022', 'Johnson', 'El Paso', 'Texas', '79916');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('54', 'ibiaggelli1h', 'Egj360zBnVP', '9/17/2022', '916-532-9247', 'idongate1h@topsy.com', 'Maddy', 'Iona', '3576639912092064', '715', '4/19/2022', 'Packers', 'Sacramento', 'California', '95894');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('55', 'ydakhno1i', '4WPwLU', '3/5/2023', '304-817-6385', 'ywestley1i@ibm.com', 'Wilek', 'Yorker', '5559404752566719', '910', '5/15/2022', 'Waxwing', 'Huntington', 'West Virginia', '25770');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('56', 'rsewart1j', 'SVRmen', '8/23/2022', '281-486-1998', 'ralmeida1j@g.co', 'Rufe', 'Raynor', '3565608133361833', '170', '3/20/2023', 'Mesta', 'Houston', 'Texas', '77050');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('57', 'lcheak1k', 'epf9J4wjuoK', '10/17/2022', '520-640-1962', 'lnutley1k@nationalgeographic.com', 'Opalina', 'Lucille', '3563227093574640', '333', '7/7/2022', 'Burrows', 'Tucson', 'Arizona', '85705');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('58', 'bshatford1l', 'A5qgfToJED', '3/15/2023', '423-205-8429', 'bmemory1l@opera.com', 'Ariel', 'Berte', '3576639867768379', '32', '5/21/2022', '5th', 'Chattanooga', 'Tennessee', '37410');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('59', 'vbehnke1m', 'QBVJAFlWh02t', '10/2/2022', '757-981-4113', 'vhembrow1m@drupal.org', 'Jarred', 'Vonnie', '675947187024777484', '738', '7/2/2022', 'Glacier Hill', 'Virginia Beach', 'Virginia', '23459');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('60', 'fgoudard1n', 'gwleMYXnygq', '12/28/2022', '919-366-9581', 'fshotton1n@umn.edu', 'Lucho', 'Fan', '3540676694722792', '761', '6/25/2022', 'Hooker', 'Raleigh', 'North Carolina', '27635');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('61', 'eclunie1o', 'q3cWBa', '5/4/2022', '480-708-3283', 'equayle1o@salon.com', 'Rena', 'Ethyl', '3569806374925011', '990', '1/2/2023', 'Meadow Valley', 'Apache Junction', 'Arizona', '85219');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('62', 'cbault1p', 'pakEOMa', '2/9/2023', '619-780-2589', 'cdowthwaite1p@domainmarket.com', 'Rakel', 'Clemmy', '6759730248341655469', '225', '5/20/2022', 'Trailsway', 'San Diego', 'California', '92165');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('63', 'vandraud1q', 'i66SNbSsFd', '5/10/2022', '850-884-1089', 'vsharram1q@baidu.com', 'Barry', 'Violet', '3549277585618180', '291', '10/7/2022', 'Crest Line', 'Pensacola', 'Florida', '32595');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('64', 'etadman1r', 'tLLlCmAS', '6/29/2022', '540-595-0701', 'etanguy1r@soundcloud.com', 'Orton', 'Enriqueta', '3549291281749793', '637', '11/20/2022', 'Namekagon', 'Roanoke', 'Virginia', '24040');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('65', 'dsiddele1s', 'nFkD0cGjkK', '5/17/2022', '517-604-2756', 'dmcgreary1s@bloglovin.com', 'Elvis', 'Dian', '4913215051296467', '773', '11/13/2022', 'Hooker', 'Lansing', 'Michigan', '48901');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('66', 'ioakwood1t', 'r15Ka25v', '5/8/2022', '559-943-8666', 'iwhipple1t@springer.com', 'Fayette', 'Inger', '5610720311102531', '508', '2/22/2023', 'Clove', 'Fresno', 'California', '93709');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('67', 'sfinci1u', '0YsFzk0', '11/18/2022', '309-436-4315', 'sanfosso1u@google.com.br', 'Frederique', 'Sharline', '348269302812666', '170', '7/16/2022', 'Union', 'Carol Stream', 'Illinois', '60158');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('68', 'mhazeldene1v', 'oBR1Xcj880', '3/18/2023', '713-273-8832', 'mdorricott1v@networksolutions.com', 'Daveta', 'Marlie', '3587190108000021', '508', '1/11/2023', 'Macpherson', 'Houston', 'Texas', '77271');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('69', 'ktweddle1w', 'hep2UdzP6F4', '1/4/2023', '240-556-4349', 'klamswood1w@oakley.com', 'Mercy', 'Kilian', '5602256828815836', '756', '9/14/2022', 'Northport', 'Silver Spring', 'Maryland', '20918');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('70', 'elife1x', 'QwOt8fec42', '3/28/2023', '303-392-7021', 'enarey1x@soundcloud.com', 'Alf', 'Erek', '3551133292386758', '626', '10/13/2022', 'Huxley', 'Denver', 'Colorado', '80243');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('71', 'jhenker1y', 'dCKaVW', '11/4/2022', '520-663-2337', 'jcogar1y@blogs.com', 'Pen', 'Jaimie', '4913932609624897', '946', '7/31/2022', 'Arkansas', 'Tucson', 'Arizona', '85743');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('72', 'jlording1z', 'Sv3eKD', '12/10/2022', '936-496-3130', 'jwhatford1z@tripod.com', 'Gordan', 'Jody', '3528932854153708', '901', '11/11/2022', 'Hoepker', 'Houston', 'Texas', '77090');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('73', 'nantley20', 'iiOKac', '3/23/2023', '520-925-4941', 'nlindell20@homestead.com', 'Gwennie', 'Nonnah', '3557601567474172', '812', '1/18/2023', 'Rieder', 'Tucson', 'Arizona', '85743');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('74', 'nhafford21', 'yAZRH0ts', '1/5/2023', '714-627-1475', 'nfaley21@canalblog.com', 'Graehme', 'Nikita', '337941812183084', '6', '10/30/2022', 'Canary', 'Fullerton', 'California', '92835');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('75', 'pcollumbell22', 'zuz7Io', '11/26/2022', '360-717-1209', 'ptotton22@gizmodo.com', 'Thaxter', 'Paxton', '3544918531831568', '73', '12/2/2022', 'Browning', 'Vancouver', 'Washington', '98687');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('76', 'scapps23', 'U9nB26FUxvrS', '12/11/2022', '269-393-6748', 'scovil23@phoca.cz', 'Doralia', 'Sisile', '4041376156121', '264', '7/16/2022', '6th', 'Kalamazoo', 'Michigan', '49006');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('77', 'hsawdy24', '9aeeVP', '9/3/2022', '559-262-7836', 'hmingame24@google.com.br', 'Carlina', 'Hamil', '374622826510926', '215', '9/5/2022', 'Pierstorff', 'Fresno', 'California', '93786');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('78', 'btiplady25', 'aqyMCZnsBUj', '4/17/2022', '719-973-9491', 'bhowkins25@answers.com', 'Alphard', 'Bennie', '5598017370757552', '763', '12/6/2022', 'Lyons', 'Colorado Springs', 'Colorado', '80920');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('79', 'ndebullion26', 'wScvKCz0yD73', '7/2/2022', '585-864-3058', 'natkins26@netlog.com', 'Charlotte', 'Nananne', '5108752447086436', '782', '5/4/2022', 'Swallow', 'Rochester', 'New York', '14646');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('80', 'rguion27', 'lRqn9q', '4/25/2022', '814-145-0538', 'rspilsbury27@wikipedia.org', 'Edna', 'Ramsay', '4017950349761', '778', '10/7/2022', 'Shoshone', 'Erie', 'Pennsylvania', '16510');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('81', 'peberst28', 'qIOZcdN7Z7', '7/26/2022', '937-418-7716', 'psallans28@hexun.com', 'Binnie', 'Pip', '4936020216924794', '161', '4/8/2023', 'Loftsgordon', 'Springfield', 'Ohio', '45505');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('82', 'aepsley29', 'WC2j12QyV', '9/23/2022', '605-164-2597', 'acaseri29@nyu.edu', 'Mariana', 'Aubine', '347560355541710', '480', '4/5/2023', 'Fulton', 'Sioux Falls', 'South Dakota', '57198');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('83', 'asantora2a', 'r4SfHts2S0P', '6/28/2022', '410-300-1660', 'abrigginshaw2a@parallels.com', 'Tasia', 'Ashien', '630480287693699098', '370', '3/27/2023', 'Service', 'Baltimore', 'Maryland', '21265');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('84', 'yguile2b', 'AiVsaH5OA06', '7/4/2022', '646-153-3656', 'ysampson2b@umn.edu', 'Licha', 'Yovonnda', '30241058840061', '995', '4/7/2023', 'Carpenter', 'New York City', 'New York', '10060');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('85', 'csyphas2c', 'sPp8RUX4nJ7', '11/18/2022', '805-766-3947', 'codooley2c@phpbb.com', 'Lona', 'Cyrillus', '3545743290546697', '303', '2/4/2023', '8th', 'Bakersfield', 'California', '93311');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('86', 'vwestberg2d', 'Gzz3EpUjfb', '1/1/2023', '209-357-1767', 'vmackniely2d@princeton.edu', 'Cosimo', 'Vladamir', '5100172057570793', '299', '12/13/2022', 'Upham', 'Stockton', 'California', '95205');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('87', 'nmccalister2e', 'QrKRprBQH', '4/14/2023', '210-338-0673', 'nneill2e@themeforest.net', 'Bard', 'Noreen', '3585088985045766', '178', '2/18/2023', 'Sunnyside', 'San Antonio', 'Texas', '78225');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('88', 'nhabbert2f', '5yH8cgcB', '12/21/2022', '336-703-4510', 'norsman2f@ning.com', 'Aleda', 'Nicolis', '6762140267922887', '632', '12/5/2022', 'Corben', 'Winston Salem', 'North Carolina', '27157');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('89', 'mmonroe2g', 'rKGCEp8SmOMW', '5/8/2022', '559-258-7924', 'mclarridge2g@virginia.edu', 'Seward', 'Mellisent', '5602231380458069', '275', '3/5/2023', 'Dorton', 'Fullerton', 'California', '92640');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('90', 'rgreason2h', 'YD6ohe4Y', '1/1/2023', '313-953-7252', 'rtirte2h@creativecommons.org', 'Clarabelle', 'Rriocard', '374283342468113', '372', '5/7/2022', 'Packers', 'Detroit', 'Michigan', '48267');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('91', 'lsmee2i', '2U8fmxs8I', '1/19/2023', '989-452-5506', 'lmcnirlin2i@webmd.com', 'Clary', 'Lynnell', '374283414057976', '553', '6/2/2022', 'Village', 'Saginaw', 'Michigan', '48604');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('92', 'gwitsey2j', 'ALIJIGXD3p', '7/28/2022', '717-881-3092', 'gbethell2j@youtube.com', 'Haslett', 'Giacopo', '30288418432733', '28', '3/3/2023', 'Monument', 'Lancaster', 'Pennsylvania', '17605');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('93', 'zfowell2k', 'bjRIRipL', '2/28/2023', '251-364-3177', 'zsilson2k@usda.gov', 'Henka', 'Zulema', '373063409491682', '526', '6/29/2022', 'Bartillon', 'Mobile', 'Alabama', '36616');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('94', 'dkamenar2l', '650ZSq', '3/1/2023', '404-579-3270', 'dchampniss2l@de.vu', 'Annabella', 'Doralin', '4017950039768', '721', '11/2/2022', 'Sycamore', 'Atlanta', 'Georgia', '31132');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('95', 'tliepmann2m', 'npdyfncpFQM', '12/6/2022', '510-521-8408', 'tcrutch2m@mapquest.com', 'Burr', 'Tildy', '6763516277999875', '375', '9/6/2022', 'Aberg', 'Oakland', 'California', '94627');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('96', 'emarin2n', 'axHTYI', '5/18/2022', '860-182-7341', 'ehopewell2n@ftc.gov', 'Julina', 'Emmalee', '201860606759003', '149', '6/23/2022', 'Elgar', 'Hartford', 'Connecticut', '06140');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('97', 'brisborough2o', 'WkidW55k', '12/4/2022', '804-353-7338', 'bskirving2o@linkedin.com', 'Salli', 'Bartholomew', '63049868727294184', '396', '2/18/2023', 'Quincy', 'Richmond', 'Virginia', '23203');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('98', 'mfeatherstonhalgh2p', 'YbuWcaQor', '3/21/2023', '717-852-8342', 'msaltsberger2p@etsy.com', 'Minnnie', 'Michaelina', '6304525960963821', '346', '5/16/2022', 'Hudson', 'Lancaster', 'Pennsylvania', '17622');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('99', 'eannand2q', 'Zb2VufypcY', '2/14/2023', '316-112-0751', 'ebuckberry2q@stumbleupon.com', 'Laughton', 'Ebonee', '3579139549281302', '875', '1/23/2023', 'Namekagon', 'Wichita', 'Kansas', '67205');
INSERT INTO Creators (creator_id, username, password, date_made, phone_number, email_address, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('100', 'grumbelow2r', 'gmBo5bZbJbdU', '12/11/2022', '904-998-8524', 'gcarff2r@icio.us', 'Lorri', 'Gina', '3549025775725855', '559', '8/10/2022', 'Mockingbird', 'Jacksonville', 'Florida', '32259');

--# Episodes
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('1', '482', '2538307', '25', 'Episodeqjmoq', 'Podcast167', 'Playlistsbpw9');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('2', '205', '9649811', '42', 'Episodeqzmee', 'Podcast750', 'PlaylistC8cLv');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('3', '290', '4692535', '36', 'Episodeikjwd', 'Podcast543', 'PlaylistYXiFD');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('4', '3', '3062280', '10', 'Episodevumna', 'Podcast902', 'Playlist585Kg');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('5', '488', '8662826', '49', 'Episoderkhde', 'Podcast104', 'Playlist8lIMy');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('6', '452', '8525047', '4', 'Episodeclhgk', 'Podcast848', 'Playlist0KwY6');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('7', '95', '2446844', '1', 'Episodefitcp', 'Podcast823', 'PlaylistFaZK7');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('8', '472', '6415269', '8', 'Episodenaiij', 'Podcast934', 'PlaylisthhAaY');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('9', '413', '647607', '19', 'Episodetgcmo', 'Podcast935', 'PlaylistFBme3');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('10', '170', '9495095', '36', 'Episodesuzpc', 'Podcast111', 'PlaylistthFj7');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('11', '426', '3780896', '46', 'Episodeerhan', 'Podcast372', 'PlaylistwTi5r');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('12', '294', '4812842', '20', 'Episodeofvgd', 'Podcast284', 'PlaylistmmAOr');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('13', '172', '7216049', '37', 'Episodeweesp', 'Podcast067', 'PlaylistjpaLX');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('14', '54', '4145020', '37', 'Episodeuzama', 'Podcast925', 'PlaylistVcaM7');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('15', '161', '6439011', '25', 'Episodekikva', 'Podcast836', 'PlaylisthzDnl');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('16', '243', '8802658', '3', 'Episodehvhio', 'Podcast560', 'Playlist7c7Ns');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('17', '273', '1049727', '31', 'Episodeivkct', 'Podcast327', 'PlaylistVi0Nc');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('18', '449', '974136', '46', 'Episodeixlgw', 'Podcast507', 'PlaylistVT6CX');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('19', '400', '976511', '9', 'Episodesfyem', 'Podcast346', 'PlaylistdZtWF');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('20', '410', '4352036', '2', 'Episodewxzzb', 'Podcast976', 'Playlist0qknT');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('21', '490', '5708351', '3', 'Episodekqufc', 'Podcast361', 'PlaylistVmfXs');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('22', '499', '7514520', '30', 'Episodefluud', 'Podcast313', 'PlaylistX8am2');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('23', '133', '3242560', '25', 'Episodelmsvi', 'Podcast445', 'PlaylistTcxxH');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('24', '475', '7416591', '18', 'Episodeyaomd', 'Podcast733', 'PlaylistsffeQ');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('25', '306', '7401012', '28', 'Episodeceijt', 'Podcast319', 'PlaylistpnP75');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('26', '332', '6456891', '40', 'Episodeoetrd', 'Podcast247', 'PlaylistGNYof');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('27', '274', '28446', '25', 'Episodejgtwc', 'Podcast432', 'Playlistsf8YK');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('28', '329', '1445584', '40', 'Episodevpflf', 'Podcast287', 'PlaylistXb4tp');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('29', '92', '6448949', '21', 'Episodezlhxu', 'Podcast034', 'PlaylistHVwSn');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('30', '323', '8994047', '48', 'Episodejbaii', 'Podcast330', 'Playlistr28uC');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('31', '25', '6490194', '10', 'Episodehxirk', 'Podcast794', 'PlaylistaO7OQ');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('32', '407', '4038090', '49', 'Episodefabfm', 'Podcast194', 'Playlist8EUEB');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('33', '10', '9118291', '48', 'Episodeyzgpy', 'Podcast574', 'PlaylistGgVQu');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('34', '375', '5020179', '42', 'Episodezmzpr', 'Podcast542', 'PlaylistPPLGg');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('35', '361', '7762396', '7', 'Episodehlawn', 'Podcast276', 'PlaylistrapBR');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('36', '212', '1813943', '29', 'Episodeieqsv', 'Podcast503', 'PlaylisteTynD');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('37', '120', '507296', '41', 'Episodeofitt', 'Podcast618', 'Playlist6plHP');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('38', '376', '228387', '22', 'Episodesbhcb', 'Podcast949', 'Playlist3QBJP');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('39', '452', '9063081', '11', 'Episodeigtuf', 'Podcast515', 'PlaylisttF42b');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('40', '301', '3880191', '26', 'Episodeaxlqx', 'Podcast834', 'PlaylistqWOIl');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('41', '66', '3776330', '37', 'Episodekeynh', 'Podcast401', 'PlaylistP06aT');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('42', '16', '1024242', '18', 'Episodeirbsb', 'Podcast508', 'PlaylistSAhvC');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('43', '52', '3215650', '44', 'Episodegjjhq', 'Podcast469', 'PlaylistCX6XA');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('44', '349', '4234683', '36', 'Episodessnmf', 'Podcast969', 'PlaylistJ53FK');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('45', '206', '5656364', '45', 'Episoderxsem', 'Podcast649', 'Playlist36Vl3');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('46', '410', '9257457', '33', 'Episodehmhcy', 'Podcast415', 'PlaylistDngvM');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('47', '159', '7633322', '31', 'Episodepilpk', 'Podcast574', 'Playlistkw80K');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('48', '156', '1333191', '24', 'Episodeikgmw', 'Podcast560', 'PlaylistVFE57');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('49', '5', '2885771', '15', 'Episodevwhsp', 'Podcast639', 'PlaylistNZA0w');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('50', '353', '7917037', '35', 'Episodebyqna', 'Podcast789', 'PlaylistTkFC2');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('51', '315', '5823350', '50', 'Episodexsdyw', 'Podcast934', 'PlaylistP2q42');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('52', '25', '971413', '22', 'Episodeaheph', 'Podcast113', 'Playlist5OHUb');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('53', '419', '226217', '25', 'Episoderegmt', 'Podcast855', 'PlaylistqMpCX');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('54', '87', '559341', '9', 'Episodejwytw', 'Podcast928', 'Playlist5QDn0');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('55', '35', '3626467', '41', 'Episodejrqwe', 'Podcast317', 'PlaylistK4vfC');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('56', '436', '8238663', '44', 'Episodeiggpr', 'Podcast577', 'PlaylistOTKkA');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('57', '112', '1574499', '37', 'Episodegglae', 'Podcast958', 'PlaylistXlZ5P');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('58', '358', '9317866', '47', 'Episodefawjm', 'Podcast642', 'PlaylistNIolh');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('59', '385', '5674338', '11', 'Episodezdvbp', 'Podcast473', 'PlaylistVFkDO');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('60', '100', '9914380', '33', 'Episodevflxr', 'Podcast771', 'PlaylistEAqE1');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('61', '75', '8501125', '14', 'Episodeguyab', 'Podcast956', 'PlaylistI2YbR');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('62', '185', '9735112', '23', 'Episodecytom', 'Podcast422', 'PlaylistE8wIv');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('63', '385', '8083710', '3', 'Episodexwprg', 'Podcast022', 'PlaylistSdsUM');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('64', '205', '810577', '1', 'Episodevrlhh', 'Podcast143', 'PlaylisthNql9');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('65', '317', '9606745', '48', 'Episodesddan', 'Podcast238', 'Playlistc16OF');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('66', '139', '7236430', '12', 'Episodelefhb', 'Podcast965', 'PlaylistnpLN5');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('67', '326', '8696149', '26', 'Episodesfkzd', 'Podcast475', 'PlaylistH3cxz');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('68', '246', '731327', '26', 'Episoderixwt', 'Podcast252', 'PlaylistVALsv');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('69', '311', '6366000', '48', 'Episodewzpcx', 'Podcast395', 'Playlistzsq0q');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('70', '113', '2280060', '25', 'Episodexlpor', 'Podcast336', 'PlaylistQ43ff');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('71', '313', '8662929', '44', 'Episodefcxvi', 'Podcast469', 'Playlist3HNVP');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('72', '343', '2799482', '9', 'Episodeuzpvc', 'Podcast689', 'PlaylistqRxVz');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('73', '385', '3918890', '25', 'Episodehrhwf', 'Podcast796', 'PlaylistmspEG');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('74', '456', '1348688', '25', 'Episodenzwmt', 'Podcast222', 'PlaylistLJJ62');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('75', '284', '2906726', '18', 'Episodepcfnw', 'Podcast466', 'PlaylistAXCBo');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('76', '296', '8073367', '38', 'Episoderdzcn', 'Podcast638', 'Playlist8E1zE');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('77', '84', '8192121', '14', 'Episodeknmyh', 'Podcast494', 'PlaylistlrSeU');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('78', '345', '8766136', '13', 'Episodejwqmx', 'Podcast546', 'PlaylistDgzUD');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('79', '211', '678587', '48', 'Episodeafxdc', 'Podcast130', 'Playlistsa8PB');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('80', '349', '6596810', '17', 'Episodefwnlh', 'Podcast433', 'PlaylistNMUu7');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('81', '335', '3904500', '15', 'Episodexiacl', 'Podcast483', 'PlaylistZkr22');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('82', '83', '3983198', '14', 'Episodegklpr', 'Podcast356', 'Playlistg9j9F');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('83', '69', '7363085', '23', 'Episodeddcwf', 'Podcast798', 'PlaylistcFPuV');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('84', '248', '6833555', '21', 'Episodeqnaco', 'Podcast989', 'Playlist2m9eI');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('85', '131', '568832', '24', 'Episodeeqhdf', 'Podcast025', 'PlaylisthcfzL');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('86', '482', '7189392', '44', 'Episodeurjzo', 'Podcast935', 'PlaylisttwFrz');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('87', '54', '6343690', '32', 'Episodexmlkb', 'Podcast400', 'PlaylistGTfxB');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('88', '176', '4633954', '18', 'Episodehampw', 'Podcast367', 'PlaylistmSX1a');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('89', '372', '6473764', '41', 'Episodeutwqg', 'Podcast889', 'Playlistlb54d');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('90', '440', '2343514', '43', 'Episodeniwhz', 'Podcast167', 'Playlistr8DaR');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('91', '179', '3990388', '19', 'Episodepdehv', 'Podcast429', 'PlaylistCZRkb');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('92', '239', '3772476', '7', 'Episodeyrbto', 'Podcast882', 'PlaylistdFX7o');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('93', '339', '6084118', '30', 'Episodeexjgs', 'Podcast308', 'Playlistg209D');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('94', '179', '9692600', '4', 'Episodemcoqy', 'Podcast753', 'PlaylistaKtLA');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('95', '405', '114220', '29', 'Episodegsiog', 'Podcast868', 'PlaylistWThIY');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('96', '241', '9576202', '37', 'Episodeztsvb', 'Podcast341', 'Playlist75xUf');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('97', '125', '5685097', '36', 'Episodepnwgl', 'Podcast297', 'PlaylistuR7kg');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('98', '177', '6288911', '30', 'Episodehtkfs', 'Podcast028', 'Playlist5dzlH');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('99', '149', '4188833', '48', 'Episodetyawx', 'Podcast638', 'PlaylistgnvYl');
INSERT INTO Episodes (episode_number, duration, listens, season_number, episode_name, podcast_name, playlist_name) VALUES ('100', '223', '8036660', '24', 'Episodeyuzke', 'Podcast819', 'PlaylistrgTQy');

--# Genre
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '1647065', '7311280', 'Podcast455');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '6979473', '5068111', 'Podcast874');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Musical', '3927314', '2095518', 'Podcast612');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Comedy|Thriller', '5018792', '3527873', 'Podcast649');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama|Romance', '2746109', '302751', 'Podcast061');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime|Drama', '3018360', '9133721', 'Podcast834');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery|Sci-Fi|Thriller', '600309', '9262767', 'Podcast760');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Romance', '2126352', '9427059', 'Podcast853');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Romance', '7833139', '6035756', 'Podcast689');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '9617470', '8386649', 'Podcast808');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '1571153', '5676426', 'Podcast190');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '8333087', '3769528', 'Podcast701');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Mystery|Thriller', '5171637', '2534518', 'Podcast866');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery', '6485533', '918475', 'Podcast745');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '1254674', '2869915', 'Podcast425');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure', '5034508', '9972148', 'Podcast512');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '7071898', '7269924', 'Podcast447');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Drama', '4950531', '3609125', 'Podcast942');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime', '8844384', '1090388', 'Podcast873');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '1020500', '8634070', 'Podcast612');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '3623625', '6511401', 'Podcast145');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime|Drama|Film-Noir|Thriller', '920009', '231151', 'Podcast213');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '5241460', '7278325', 'Podcast194');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama', '8231809', '453342', 'Podcast745');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Sci-Fi|War', '1520960', '5706337', 'Podcast405');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Sci-Fi', '5109896', '231384', 'Podcast694');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Romance', '6932260', '5318291', 'Podcast225');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Adventure|Thriller|War', '5650253', '9059867', 'Podcast726');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Sci-Fi', '1414892', '4811124', 'Podcast857');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '6846495', '5322960', 'Podcast366');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|War', '1135642', '6121415', 'Podcast870');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Musical|Romance', '2598092', '1513928', 'Podcast370');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure|Drama', '8119408', '8366515', 'Podcast430');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure|Fantasy|Thriller', '1970955', '7399665', 'Podcast432');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama', '1254265', '2284532', 'Podcast665');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Romance', '2418337', '6330514', 'Podcast825');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery', '7623006', '7394069', 'Podcast624');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Crime', '6028243', '206507', 'Podcast200');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Mystery|Thriller', '9045733', '9427732', 'Podcast330');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama', '3413044', '1087276', 'Podcast338');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Comedy|Crime|Thriller', '4562857', '233855', 'Podcast261');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '7170512', '5214402', 'Podcast677');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Mystery|Thriller', '1267569', '6346594', 'Podcast423');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Romance|War', '60479', '4194558', 'Podcast482');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '7303070', '1457359', 'Podcast181');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Documentary', '5184083', '632649', 'Podcast336');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Documentary', '4673221', '5100160', 'Podcast291');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Sci-Fi|Thriller', '6448816', '558637', 'Podcast529');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Horror|Romance', '770123', '1711897', 'Podcast428');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Mystery', '9887998', '9287187', 'Podcast414');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Sci-Fi|Thriller', '6877897', '6945390', 'Podcast603');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Musical|Romance', '4586720', '6285178', 'Podcast816');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '6691885', '8389097', 'Podcast390');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '1963848', '4454044', 'Podcast850');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure|Animation|Children|Drama', '6341998', '6687263', 'Podcast447');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '2970268', '6379293', 'Podcast227');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Animation|Children', '5326019', '1261302', 'Podcast537');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Romance', '2545226', '4825278', 'Podcast513');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama|Romance', '3281891', '9643604', 'Podcast349');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('(no genres listed)', '950953', '4230321', 'Podcast264');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('(no genres listed)', '6244414', '1237694', 'Podcast407');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Animation|Children|Sci-Fi', '6722557', '2695073', 'Podcast252');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Horror|Sci-Fi|Thriller', '5468187', '2563107', 'Podcast849');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '2913868', '4016781', 'Podcast168');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Sci-Fi|Thriller', '104022', '7006200', 'Podcast687');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '4409100', '7399455', 'Podcast094');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Mystery|Thriller', '6824192', '4157786', 'Podcast735');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama|Romance', '3744502', '6534771', 'Podcast237');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '543941', '4711045', 'Podcast292');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '8055673', '6258901', 'Podcast658');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Documentary', '3147582', '109044', 'Podcast331');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama', '4912535', '6776351', 'Podcast282');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Animation|Children|Fantasy', '8165853', '7862783', 'Podcast819');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Romance', '4236136', '7414973', 'Podcast701');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '7067319', '5885596', 'Podcast226');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama|Romance', '1853210', '8051868', 'Podcast296');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Documentary', '2531450', '598866', 'Podcast161');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Romance', '6636368', '2272391', 'Podcast070');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|War', '5455145', '1724573', 'Podcast999');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime|Drama|Romance|Thriller', '4114019', '5063636', 'Podcast839');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Romance', '1633220', '2378511', 'Podcast235');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery|Thriller', '4069438', '4051714', 'Podcast753');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Fantasy|Romance', '4179158', '6017496', 'Podcast663');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure|Animation|Children|Drama|Fantasy', '6246867', '6453510', 'Podcast006');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Romance', '2286964', '5143788', 'Podcast281');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('(no genres listed)', '7480909', '6999904', 'Podcast831');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Romance', '8265700', '7498436', 'Podcast747');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery|Romance', '6732912', '5941096', 'Podcast738');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Documentary', '4956799', '122482', 'Podcast707');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '4117447', '6259196', 'Podcast075');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Fantasy|Horror|Thriller', '2218840', '3552734', 'Podcast074');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '3789927', '3159766', 'Podcast696');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Sci-Fi', '4674588', '3603527', 'Podcast263');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama', '9731940', '8508326', 'Podcast988');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Animation|Comedy', '7947272', '6903945', 'Podcast796');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '4081775', '4253235', 'Podcast832');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Thriller', '3102692', '8748379', 'Podcast279');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '5460733', '7531340', 'Podcast201');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime|Drama|Mystery|Thriller', '3383654', '7731090', 'Podcast969');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama|Romance', '5407101', '3907556', 'Podcast968');

--# Inventory
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('4137237', '9', 'L', '5/12/2022', '4/21/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('441126', '56', '2XL', '1/12/2023', '5/25/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('1631355', '73', 'XS', '3/11/2023', '4/29/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9734144', '72', 'S', '12/3/2022', '1/13/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5807033', '76', '2XL', '10/2/2022', '1/10/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('6600295', '25', 'S', '12/8/2022', '6/20/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('8221773', '94', 'L', '4/2/2022', '7/24/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('809113', '93', 'XS', '8/7/2022', '4/18/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5983354', '11', '3XL', '5/12/2022', '9/1/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2435760', '15', '2XL', '10/15/2022', '2/20/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5731386', '78', 'M', '11/21/2022', '8/19/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('8381419', '23', 'XS', '3/12/2023', '2/24/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2974933', '67', 'XS', '7/15/2023', '6/2/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('7699937', '67', 'L', '4/12/2023', '10/12/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5623205', '73', 'M', '1/19/2023', '7/18/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9885691', '82', 'S', '3/9/2022', '4/14/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('1034194', '46', '3XL', '3/3/2022', '5/17/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('8506915', '72', 'L', '3/3/2022', '6/8/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5905582', '38', 'XL', '1/11/2023', '3/12/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9122102', '28', 'XS', '10/17/2022', '9/16/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2778835', '71', 'L', '6/19/2022', '6/21/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9767977', '15', '2XL', '6/27/2023', '7/2/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9301956', '7', 'XL', '8/4/2022', '1/20/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9840924', '6', 'L', '6/7/2022', '6/20/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('459972', '1', 'XS', '2/25/2023', '3/22/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('6122240', '99', 'M', '3/11/2022', '1/17/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('3213317', '15', '2XL', '12/25/2022', '5/26/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5824929', '54', 'XS', '5/19/2022', '6/3/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('8760592', '90', 'S', '10/11/2022', '8/9/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5675988', '85', 'XS', '5/2/2023', '10/19/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('637526', '25', 'XS', '5/3/2022', '10/16/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('64712', '45', '2XL', '3/13/2023', '3/8/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('6822706', '13', 'XL', '2/17/2023', '1/23/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('3088033', '34', 'XS', '1/2/2023', '4/18/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2786836', '36', 'XS', '4/15/2022', '2/22/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('7085796', '29', 'M', '11/29/2022', '7/5/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('82320', '28', 'XS', '4/12/2023', '5/15/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('3275664', '4', 'XL', '12/20/2022', '7/25/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9831804', '92', '3XL', '5/18/2022', '10/16/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5178692', '21', '3XL', '8/3/2022', '9/24/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('1082446', '88', '3XL', '8/16/2022', '6/18/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9809496', '58', 'L', '2/3/2023', '6/12/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('4326271', '25', 'S', '7/30/2022', '10/10/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9103404', '94', '3XL', '7/23/2022', '3/16/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('4816842', '64', 'S', '5/2/2022', '7/8/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('439517', '10', '2XL', '12/5/2022', '5/9/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('3410385', '97', 'S', '12/27/2022', '5/6/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5402698', '7', '2XL', '2/27/2023', '8/12/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('3030069', '80', '3XL', '9/1/2022', '2/27/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('6506478', '29', 'S', '6/6/2022', '9/15/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('156150', '61', '3XL', '4/26/2023', '12/29/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5488878', '88', '2XL', '4/1/2023', '1/24/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5292492', '25', 'L', '5/5/2022', '2/7/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('3429109', '31', 'XS', '10/11/2022', '3/17/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2738177', '7', 'S', '7/9/2022', '5/30/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('1328726', '55', 'XS', '12/13/2022', '5/26/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5641387', '76', '2XL', '7/10/2023', '2/6/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9533187', '39', 'L', '2/1/2023', '12/10/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2730167', '44', 'XL', '3/20/2023', '3/17/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('7014413', '20', 'S', '2/7/2023', '1/17/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('6818803', '59', 'XS', '7/19/2023', '5/10/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2443104', '43', '3XL', '1/21/2023', '2/2/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('6090318', '50', '2XL', '3/4/2023', '1/9/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('3956000', '59', 'XL', '5/13/2022', '10/17/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('852379', '13', 'XS', '8/4/2022', '1/14/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('3367844', '67', '2XL', '4/29/2023', '3/30/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('140827', '99', '3XL', '4/21/2023', '10/11/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('684031', '2', 'M', '1/27/2023', '7/26/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2651939', '64', 'L', '5/24/2023', '3/1/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2073146', '95', 'XL', '5/3/2023', '1/17/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9730966', '32', 'XL', '6/26/2023', '5/2/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2559808', '72', 'S', '7/3/2023', '4/23/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('7395604', '19', 'S', '4/13/2023', '4/19/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9505903', '99', 'M', '2/26/2023', '7/13/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('295223', '42', 'M', '11/28/2022', '11/1/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('8732177', '58', 'XL', '9/26/2022', '4/1/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2096427', '51', 'M', '6/12/2022', '7/11/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2819789', '72', '3XL', '3/11/2022', '11/28/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9072274', '58', 'XL', '8/26/2022', '3/26/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('4892392', '21', 'L', '1/30/2023', '5/23/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('4032292', '36', 'XS', '7/15/2023', '11/17/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('6393944', '98', '3XL', '5/11/2023', '10/22/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('1490121', '29', 'M', '10/8/2022', '8/11/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('1166009', '86', 'XL', '2/8/2023', '9/6/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('4326481', '15', '3XL', '11/19/2022', '9/1/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('7840621', '14', '2XL', '11/6/2022', '12/1/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('4558469', '6', 'XL', '4/8/2022', '8/25/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9582917', '69', 'S', '11/24/2022', '11/8/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('6947589', '82', '2XL', '6/18/2023', '11/4/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9155747', '41', 'L', '5/11/2023', '12/18/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('2385889', '68', 'XL', '11/5/2022', '1/25/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('9813784', '10', 'M', '10/5/2022', '7/22/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('8714286', '6', 'XL', '3/12/2023', '7/7/2023');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('7185154', '33', '2XL', '4/10/2022', '11/12/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('7606159', '23', 'L', '3/18/2022', '6/2/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('1966297', '22', 'L', '9/5/2022', '3/5/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('8706845', '20', 'L', '7/3/2023', '3/5/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('5738038', '96', 'XS', '3/1/2023', '7/14/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('7895986', '35', '2XL', '5/16/2023', '6/13/2022');
INSERT INTO Inventory (total_in_stock, item_number, available_sizes, date_last_restock, date_next_restock) VALUES ('8437903', '86', 'L', '3/3/2023', '6/23/2023');

--# Merchandise
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('1', 'Xkemuflruxvztp', '2XL', '12/18/2022', '2/8/2023', 'North Carolina', 'Acker', 'Charlotte', '28256', '70', '13', '5905582');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('2', 'Hwqrmrblysauva', 'M', '8/7/2022', '10/8/2022', 'Tennessee', 'Troy', 'Memphis', '38136', '22', '993', '4816842');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('3', 'Vssgktfzczdxgx', 'M', '4/14/2023', '6/12/2022', 'California', 'Hermina', 'San Francisco', '94105', '8', '266', '8706845');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('4', 'Toivsrqsotyaih', 'XS', '7/26/2022', '11/22/2022', 'Texas', 'Warrior', 'San Antonio', '78260', '59', '923', '9301956');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('5', 'Bcsvutuuyupbwp', '3XL', '4/11/2023', '8/17/2022', 'District of Columbia', 'Delaware', 'Washington', '20551', '76', '201', '9840924');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('6', 'Qpebbiugtdrdmq', 'XS', '6/23/2022', '9/22/2022', 'Kansas', 'Mariners Cove', 'Shawnee Mission', '66225', '18', '27', '9533187');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('7', 'Ngybcdupcyhevd', '3XL', '5/23/2022', '6/8/2022', 'New York', 'Longview', 'Elmira', '14905', '46', '960', '6822706');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('8', 'Kvhbslsxgzpicm', '3XL', '7/22/2022', '9/17/2022', 'District of Columbia', 'Express', 'Washington', '20397', '13', '967', '9103404');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('9', 'Hmlqkadmfubixm', 'XS', '1/2/2023', '4/28/2022', 'Utah', 'Harper', 'Salt Lake City', '84115', '96', '92', '6947589');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('10', 'Ctjmvpfbxcelub', '2XL', '6/13/2022', '1/9/2023', 'Texas', 'Sutherland', 'Pasadena', '77505', '15', '593', '8437903');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('11', 'Sxpqgzfhiqgzlh', '2XL', '9/1/2022', '8/7/2022', 'Delaware', 'Scott', 'Newark', '19725', '28', '966', '1082446');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('12', 'Aafjnfxaxuymiz', '3XL', '1/5/2023', '11/14/2022', 'North Carolina', 'High Crossing', 'Raleigh', '27605', '85', '592', '1490121');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('13', 'Xozfrqpwfcjsuu', 'L', '12/9/2022', '9/4/2022', 'Utah', 'Moland', 'Salt Lake City', '84120', '74', '855', '5178692');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('14', 'Izhbwlsilctvgi', 'L', '3/4/2023', '7/1/2022', 'Louisiana', 'Pawling', 'Metairie', '70005', '7', '568', '5292492');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('15', 'Dflwqfyhxtfvkn', '2XL', '5/3/2022', '7/9/2022', 'Florida', 'La Follette', 'Jacksonville', '32255', '41', '849', '156150');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('16', 'Iqkodebgsjwjqf', 'L', '9/18/2022', '11/14/2022', 'Alabama', 'Buell', 'Birmingham', '35236', '79', '206', '2385889');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('17', 'Dzwhltjhvpchqm', 'XS', '4/9/2023', '5/15/2022', 'Missouri', 'Garrison', 'Kansas City', '64109', '14', '479', '2073146');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('18', 'Yrofsabaaelewo', 'S', '9/14/2022', '6/2/2022', 'Alabama', 'Eliot', 'Birmingham', '35285', '28', '81', '9730966');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('19', 'Rexvgnvwcryzqs', '3XL', '12/27/2022', '5/2/2022', 'Illinois', 'Lerdahl', 'Springfield', '62776', '13', '623', '2435760');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('20', 'Mdqasirlurocrj', '2XL', '9/11/2022', '6/17/2022', 'California', 'Village Green', 'Anaheim', '92805', '31', '830', '3429109');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('21', 'Znqhgvqjqnfaki', 'XL', '5/29/2022', '12/1/2022', 'Kentucky', 'Huxley', 'Louisville', '40298', '29', '239', '8506915');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('22', 'Ghtmtqtrgvydvp', 'XL', '3/1/2023', '7/15/2022', 'California', 'Columbus', 'San Francisco', '94110', '71', '986', '7895986');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('23', 'Arrxzrmhqgjnwy', 'XL', '9/17/2022', '2/13/2023', 'New York', 'Monterey', 'Brooklyn', '11220', '54', '915', '7840621');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('24', 'Jfaaacxcyqfieq', '2XL', '12/22/2022', '6/17/2022', 'Louisiana', 'Doe Crossing', 'Baton Rouge', '70805', '3', '418', '6122240');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('25', 'Fdztwwaqpxgalx', 'M', '3/16/2023', '8/29/2022', 'California', 'Sheridan', 'Fresno', '93726', '31', '719', '2443104');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('26', 'Bmpqvzmvnyirsc', 'L', '8/22/2022', '1/24/2023', 'Minnesota', 'Hansons', 'Maple Plain', '55579', '93', '93', '8437903');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('27', 'Xvyjmojamnhxey', 'L', '5/24/2022', '1/13/2023', 'Texas', '3rd', 'El Paso', '79940', '76', '967', '2651939');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('28', 'Uidutbnzwfrizj', 'XL', '5/5/2022', '10/15/2022', 'North Carolina', 'Mccormick', 'Greensboro', '27415', '20', '441', '637526');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('29', 'Ofinfhcrjfhyha', 'XS', '7/19/2022', '10/14/2022', 'Texas', 'Buhler', 'Fort Worth', '76129', '35', '793', '439517');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('30', 'Dyufhhipcxkuny', '2XL', '4/22/2022', '3/21/2023', 'Texas', 'Holmberg', 'Beaumont', '77713', '59', '652', '9809496');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('31', 'Pyvfvnqgvajuoq', 'XS', '12/14/2022', '1/25/2023', 'New York', 'Mosinee', 'Brooklyn', '11236', '98', '501', '9809496');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('32', 'Jylzjyxjdmiymt', 'XL', '2/14/2023', '1/25/2023', 'Texas', 'Ramsey', 'San Angelo', '76905', '5', '656', '3088033');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('33', 'Eabgqjggvkynbu', 'L', '2/21/2023', '10/24/2022', 'Florida', 'Messerschmidt', 'Fort Lauderdale', '33355', '50', '526', '5623205');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('34', 'Fyiovgiolywwst', 'L', '8/13/2022', '10/5/2022', 'Pennsylvania', 'Lunder', 'Erie', '16510', '8', '494', '9885691');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('35', 'Dwxkuvwrlwkvcy', '2XL', '7/31/2022', '11/26/2022', 'Texas', 'Mallard', 'Houston', '77050', '76', '473', '2778835');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('36', 'Miekipehthmrfb', '2XL', '11/19/2022', '8/12/2022', 'Kansas', 'Pleasure', 'Shawnee Mission', '66210', '88', '463', '9155747');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('37', 'Xwlvqhpjhppamg', '2XL', '11/16/2022', '6/21/2022', 'California', 'Beilfuss', 'Visalia', '93291', '92', '857', '3088033');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('38', 'Qlezpcqbgdvtkw', '3XL', '1/19/2023', '10/29/2022', 'California', 'Farmco', 'Los Angeles', '90094', '18', '508', '64712');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('39', 'Lfcciajpmqgmkk', '3XL', '3/29/2023', '2/13/2023', 'Michigan', 'Longview', 'Detroit', '48267', '50', '794', '5292492');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('40', 'Djoyswwotyzkeu', 'XL', '4/14/2023', '1/16/2023', 'Idaho', 'Forster', 'Boise', '83727', '97', '457', '5488878');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('41', 'Gjkpeyeezcsvtt', 'M', '11/8/2022', '3/12/2023', 'Alabama', 'Michigan', 'Huntsville', '35895', '100', '731', '295223');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('42', 'Gymsnooeesoqhl', '3XL', '2/22/2023', '8/10/2022', 'Texas', 'Brown', 'Austin', '78749', '86', '491', '2443104');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('43', 'Oahlwyvswltewh', 'M', '4/26/2022', '11/29/2022', 'West Virginia', 'Carey', 'Huntington', '25705', '84', '489', '4326481');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('44', 'Iwaubgugwcaxkh', '2XL', '7/16/2022', '9/15/2022', 'North Carolina', 'Arapahoe', 'Charlotte', '28256', '94', '345', '3410385');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('45', 'Skoszndnvefjmo', 'XL', '1/31/2023', '5/29/2022', 'Texas', 'Del Mar', 'Houston', '77025', '95', '28', '8221773');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('46', 'Wtfabmhaytqdbn', 'L', '1/10/2023', '2/7/2023', 'Oklahoma', 'Texas', 'Norman', '73071', '59', '940', '6393944');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('47', 'Pwlrguzsstqqux', '3XL', '6/2/2022', '7/27/2022', 'Ohio', 'Sycamore', 'Dayton', '45490', '67', '470', '82320');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('48', 'Ytarrvfdrntopp', 'XL', '9/1/2022', '12/12/2022', 'Louisiana', 'Burning Wood', 'Baton Rouge', '70805', '39', '507', '2786836');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('49', 'Idnbinnxdmbkxo', 'S', '2/9/2023', '8/19/2022', 'Massachusetts', 'Anhalt', 'Boston', '02104', '71', '867', '5178692');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('50', 'Fxjhfgflmcyuak', 'M', '2/8/2023', '7/10/2022', 'Texas', 'Brentwood', 'San Antonio', '78240', '38', '539', '2819789');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('51', 'Tmyvkirfzckxux', 'M', '10/5/2022', '3/19/2023', 'Florida', 'Claremont', 'Pensacola', '32511', '88', '911', '7185154');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('52', 'Qbyeugquxgvtlp', 'XL', '10/7/2022', '5/14/2022', 'New York', 'Reinke', 'New York City', '10034', '91', '411', '4816842');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('53', 'Avtokmkclsdyhm', 'M', '3/8/2023', '1/2/2023', 'California', 'Oak', 'Fresno', '93794', '34', '934', '7014413');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('54', 'Neenftuoeikeef', 'XL', '12/5/2022', '3/27/2023', 'Tennessee', 'Graedel', 'Chattanooga', '37416', '57', '751', '156150');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('55', 'Gzrtbnswwkmgaj', 'M', '3/19/2023', '3/11/2023', 'Pennsylvania', 'Sunbrook', 'New Castle', '16107', '26', '809', '295223');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('56', 'Coyznvbyztfzdk', 'L', '2/13/2023', '7/23/2022', 'Kentucky', 'Lunder', 'Louisville', '40287', '90', '215', '3030069');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('57', 'Qwohkstdpgncqg', '3XL', '6/4/2022', '11/14/2022', 'Indiana', 'Dunning', 'Fort Wayne', '46867', '52', '302', '8221773');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('58', 'Saftqdghtjozke', 'XL', '11/28/2022', '5/15/2022', 'Texas', 'Packers', 'Houston', '77025', '69', '416', '6818803');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('59', 'Rkzuerygfwfvoy', 'XS', '10/11/2022', '12/24/2022', 'Alabama', 'Colorado', 'Birmingham', '35242', '25', '143', '8714286');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('60', 'Ugfjjaovlyhtnc', 'S', '2/11/2023', '11/11/2022', 'Kansas', 'Mcbride', 'Kansas City', '66105', '27', '843', '684031');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('61', 'Wrvdbxydwzskla', 'L', '6/1/2022', '8/3/2022', 'Louisiana', 'North', 'New Orleans', '70165', '43', '230', '6090318');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('62', 'Qdezjcoeolumjd', 'M', '6/13/2022', '9/5/2022', 'Idaho', 'Killdeer', 'Boise', '83705', '80', '184', '9885691');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('63', 'Oabnbczetpqffo', 'M', '6/21/2022', '11/30/2022', 'California', 'Springs', 'Moreno Valley', '92555', '97', '847', '6947589');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('64', 'Ktpnbgcfphcwva', 'XS', '7/27/2022', '7/6/2022', 'Florida', 'Maple Wood', 'Saint Petersburg', '33742', '90', '117', '6122240');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('65', 'Cxbzqnnroawrnk', '3XL', '10/16/2022', '8/11/2022', 'Iowa', 'Artisan', 'Des Moines', '50320', '81', '792', '9831804');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('66', 'Jvsauypzurahpk', 'M', '4/1/2023', '3/2/2023', 'New York', 'Cambridge', 'Brooklyn', '11220', '37', '614', '8381419');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('67', 'Heuowgzayegunx', '2XL', '12/28/2022', '5/13/2022', 'Connecticut', 'Marquette', 'West Hartford', '06127', '77', '451', '7014413');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('68', 'Sdxvcazlgwofrt', 'L', '3/29/2023', '7/29/2022', 'Texas', 'Derek', 'Beaumont', '77713', '87', '709', '3410385');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('69', 'Dpllxxhawyxxha', 'S', '6/12/2022', '4/22/2022', 'New York', 'Riverside', 'Albany', '12242', '11', '245', '6122240');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('70', 'Tctosnwxdocfbl', 'XS', '6/21/2022', '7/13/2022', 'Virginia', 'Sutteridge', 'Sterling', '20167', '76', '130', '8437903');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('71', 'Pjbldpxzeyzyeq', 'S', '9/28/2022', '5/3/2022', 'Louisiana', 'Larry', 'New Orleans', '70149', '53', '637', '3956000');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('72', 'Cabhtyfoajobyd', 'XL', '5/24/2022', '5/31/2022', 'Pennsylvania', '8th', 'Lancaster', '17605', '80', '482', '5402698');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('73', 'Juvqqhrlylbvpx', '3XL', '3/10/2023', '12/29/2022', 'California', 'Sugar', 'Van Nuys', '91406', '6', '789', '7085796');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('74', 'Afhlwgbrtryspq', '3XL', '2/16/2023', '10/6/2022', 'West Virginia', 'Duke', 'Charleston', '25305', '25', '893', '8221773');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('75', 'Eugpskomsbpukb', 'M', '12/12/2022', '10/17/2022', 'Florida', 'Huxley', 'Port Charlotte', '33954', '81', '360', '439517');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('76', 'Dpydixfktkbqyl', '3XL', '6/9/2022', '5/29/2022', 'Michigan', 'Bobwhite', 'Flint', '48505', '25', '83', '9122102');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('77', 'Qhsvwdibvypuda', 'L', '12/25/2022', '10/27/2022', 'District of Columbia', 'Utah', 'Washington', '20540', '8', '61', '1166009');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('78', 'Kdwoyjcxdyukmp', 'L', '6/14/2022', '10/10/2022', 'Colorado', 'Trailsway', 'Arvada', '80005', '91', '41', '3275664');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('79', 'Oeaseockswvowm', '2XL', '3/27/2023', '1/12/2023', 'Texas', '1st', 'Houston', '77288', '53', '866', '64712');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('80', 'Ppstybgxcnstfe', 'L', '9/12/2022', '11/9/2022', 'Florida', 'Shopko', 'Miami', '33124', '43', '208', '637526');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('81', 'Nwrmuwbzbgrmlk', 'M', '8/17/2022', '6/21/2022', 'Virginia', 'Crownhardt', 'Roanoke', '24040', '92', '6', '6090318');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('82', 'Hjrkuzetortcxb', '2XL', '1/2/2023', '2/14/2023', 'Tennessee', 'Crowley', 'Johnson City', '37605', '66', '643', '2778835');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('83', 'Trdszvwfipkvtu', 'XL', '6/25/2022', '4/3/2023', 'California', 'Sunnyside', 'Oceanside', '92056', '70', '650', '2096427');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('84', 'Bglivcnwinkhyc', 'XS', '5/2/2022', '1/17/2023', 'Texas', 'Mayfield', 'Austin', '78715', '16', '652', '9734144');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('85', 'Fclrzgqrlcjede', 'S', '9/12/2022', '6/21/2022', 'Texas', 'Swallow', 'Fort Worth', '76134', '99', '849', '6947589');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('86', 'Rjeocbddmdwcyt', 'S', '10/28/2022', '6/13/2022', 'Ohio', 'Lunder', 'Cleveland', '44197', '24', '712', '7085796');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('87', 'Xxyaxhbsankdgc', 'L', '8/16/2022', '12/19/2022', 'Oklahoma', 'Riverside', 'Tulsa', '74170', '52', '678', '2651939');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('88', 'Fththxsdxwisdi', 'M', '3/15/2023', '6/27/2022', 'Louisiana', 'Emmet', 'New Orleans', '70149', '79', '674', '2385889');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('89', 'Sumdyidylpgprg', 'L', '2/5/2023', '5/5/2022', 'Alabama', 'Graedel', 'Mobile', '36616', '33', '862', '9301956');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('90', 'Jrpbnhhmeotyxf', 'M', '9/28/2022', '7/8/2022', 'Kentucky', 'Transport', 'Lexington', '40510', '64', '21', '7185154');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('91', 'Ouxhkdrzomsewg', 'S', '12/15/2022', '5/10/2022', 'Illinois', 'Stuart', 'Springfield', '62776', '86', '585', '2786836');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('92', 'Qkcfohrblbmjhk', 'XL', '8/31/2022', '6/22/2022', 'Florida', 'Porter', 'Vero Beach', '32969', '79', '803', '5738038');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('93', 'Fmjbtmwqcvqoeo', '2XL', '10/16/2022', '6/29/2022', 'Illinois', 'Milwaukee', 'Peoria', '61605', '89', '68', '4558469');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('94', 'Juhdsfomicvjdh', 'L', '11/12/2022', '7/15/2022', 'North Carolina', 'Independence', 'Charlotte', '28256', '74', '96', '4816842');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('95', 'Kqverwrzpxlvla', '3XL', '10/12/2022', '2/21/2023', 'Texas', 'Merry', 'Houston', '77050', '55', '890', '295223');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('96', 'Gegtlvfeovsgha', 'M', '10/15/2022', '3/11/2023', 'Utah', 'Anderson', 'Salt Lake City', '84189', '61', '32', '3410385');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('97', 'Gpvrxnnxxuqzoo', 'XL', '6/13/2022', '2/22/2023', 'Maryland', 'Moose', 'Bethesda', '20892', '98', '149', '3088033');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('98', 'Ozykwutduhywyw', 'L', '9/29/2022', '3/15/2023', 'Ohio', 'Novick', 'Cincinnati', '45208', '49', '596', '5983354');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('99', 'Cnxlbmgjhjdspx', '3XL', '6/10/2022', '1/31/2023', 'New Hampshire', 'Fulton', 'Manchester', '03105', '80', '792', '7606159');
INSERT INTO Merchandise (item_number, item_description, available_sizes, date_last_restock, date_next_restock, supplier_state, supplier_street, supplier_city, supplier_zip_code, creator_id, supplier_id, total_in_stock) VALUES ('100', 'Pdkpzhcwwvevzm', 'XL', '1/10/2023', '8/27/2022', 'California', 'Fuller', 'Los Angeles', '90071', '60', '707', '8437903');

--# Orders
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('1', '58', '$3.56', 'Opalina Thorneloe');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('2', '100', '$7.08', 'Gertrud Lorey');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('3', '31', '$5.74', 'Zebedee Randles');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('4', '24', '$5.46', 'Lorette Ferrieroi');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('5', '73', '$5.59', 'Chick Divisek');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('6', '4', '$5.61', 'Rosene Walewski');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('7', '35', '$6.43', 'Judd Botcherby');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('8', '30', '$4.33', 'Haroun Long');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('9', '13', '$8.11', 'Anatollo Hannaby');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('10', '24', '$7.05', 'Braden Gerner');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('11', '28', '$2.98', 'Illa MacVean');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('12', '37', '$4.25', 'Randolph Matthaus');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('13', '66', '$8.36', 'Daryle Hourihan');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('14', '80', '$9.28', 'Sonja Drennan');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('15', '14', '$8.04', 'Siusan Greally');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('16', '33', '$1.95', 'Julie Matthiesen');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('17', '27', '$9.97', 'Shep Harrild');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('18', '88', '$1.87', 'Audrey Quickenden');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('19', '83', '$3.20', 'Fleur Balaisot');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('20', '73', '$2.46', 'Esta Mount');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('21', '26', '$9.29', 'Bastian Ruslen');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('22', '11', '$1.71', 'Sinclare Richold');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('23', '33', '$9.21', 'Karilynn Calcut');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('24', '35', '$8.11', 'Cordy Marde');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('25', '91', '$7.22', 'Michal Grouer');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('26', '70', '$7.44', 'Franklyn Cavy');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('27', '71', '$3.04', 'Isabel Glanders');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('28', '96', '$4.96', 'Olympe Pavlik');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('29', '73', '$3.44', 'Tabor Kilian');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('30', '66', '$8.23', 'Martica Kermath');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('31', '65', '$3.68', 'Darcey Macvey');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('32', '63', '$9.89', 'Magdalene Seeborne');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('33', '38', '$2.64', 'Lynett Todaro');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('34', '52', '$2.72', 'Garald Crispe');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('35', '55', '$5.08', 'Ambrosius Fanstone');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('36', '76', '$9.62', 'Fifi Heak');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('37', '11', '$7.40', 'Hardy Heibel');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('38', '39', '$0.14', 'Nelly Climie');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('39', '93', '$7.73', 'Florance Lemonby');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('40', '67', '$4.72', 'Jonathan Garnson');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('41', '38', '$2.81', 'Burt Mousley');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('42', '99', '$7.91', 'Noell Camili');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('43', '21', '$7.72', 'Giacinta Giacomelli');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('44', '28', '$8.98', 'Kelcy Studd');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('45', '16', '$2.00', 'Codi Mould');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('46', '71', '$4.36', 'Ettie Randals');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('47', '62', '$3.99', 'Hurleigh Mollon');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('48', '89', '$0.62', 'Theobald Blower');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('49', '99', '$5.34', 'Johannah Pinnock');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('50', '28', '$9.65', 'Tamas Heninghem');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('51', '10', '$2.67', 'Field Paulson');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('52', '63', '$0.89', 'Karoly Markovich');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('53', '66', '$6.66', 'Clywd Boothman');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('54', '42', '$3.97', 'Phylys Boyer');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('55', '88', '$8.31', 'Olvan Barwell');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('56', '73', '$4.70', 'Gannie Eckersall');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('57', '78', '$4.90', 'Kaylil Eles');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('58', '1', '$4.34', 'Leanna Clouter');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('59', '86', '$5.54', 'Codee Fulkes');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('60', '44', '$9.06', 'Jonas Powlesland');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('61', '42', '$0.61', 'Alice Iacomelli');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('62', '71', '$2.19', 'Virginie Claesens');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('63', '74', '$4.64', 'Maxine Pain');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('64', '80', '$0.34', 'Conan Cattrell');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('65', '99', '$3.73', 'Lyndsey Gladhill');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('66', '97', '$5.71', 'Tildi Ayre');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('67', '65', '$5.45', 'Garrard Keating');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('68', '78', '$5.36', 'Tova Mila');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('69', '7', '$0.60', 'Doralyn Itshak');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('70', '19', '$8.92', 'Jo Longhorn');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('71', '30', '$3.54', 'Farah Fraczak');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('72', '74', '$3.91', 'Weber Kahen');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('73', '7', '$2.28', 'Nomi Lindores');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('74', '39', '$7.75', 'Addie Mazillius');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('75', '53', '$3.43', 'Sol Conville');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('76', '98', '$2.25', 'Joli Gauchier');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('77', '8', '$0.44', 'Claretta Bradain');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('78', '91', '$1.72', 'Murdoch Grindrod');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('79', '18', '$4.52', 'Rose Hatherill');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('80', '46', '$4.59', 'Lorain Davidovsky');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('81', '13', '$7.75', 'Herschel McCromley');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('82', '10', '$0.72', 'Ynes Cardall');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('83', '67', '$2.45', 'Penrod Hauger');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('84', '37', '$9.70', 'Johann Duckett');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('85', '61', '$9.15', 'Heinrick Fehners');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('86', '34', '$7.50', 'Rollin Medgewick');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('87', '4', '$8.74', 'Barr Keeves');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('88', '60', '$6.57', 'Curry Booth');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('89', '55', '$3.99', 'Eustacia Giacopini');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('90', '44', '$2.43', 'Jamaal Dyet');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('91', '2', '$4.52', 'Nevsa Coughtrey');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('92', '63', '$0.18', 'Carlye Putton');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('93', '31', '$5.28', 'Traci Gerson');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('94', '29', '$6.52', 'Sigmund Beckitt');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('95', '89', '$0.62', 'Kenna Willford');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('96', '55', '$1.45', 'Ursa Lambrick');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('97', '86', '$8.02', 'Elinore Weare');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('98', '47', '$0.50', 'Kermit Scoble');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('99', '17', '$2.50', 'Sheila Maides');
INSERT INTO Orders (order_number, item_number, price, customer_name) VALUES ('100', '88', '$8.79', 'Zorine Maddick');

--# Playlists
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistIRqNR', '1909253', '6/15/2022', '28', '48', 'Playlist1OamY', '73');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist7nQbO', '2940528', '1/30/2023', '470', '23', 'PlaylistObpaP', '38');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistYZwrm', '1145597', '5/5/2022', '327', '13', 'Playlist9unPL', '94');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistzJu5d', '274155', '6/19/2022', '179', '26', 'PlaylistTTFcA', '23');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist8J8tP', '9042134', '2/28/2023', '476', '55', 'Playlist1kRpX', '88');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistLrwQz', '7839729', '5/7/2022', '4', '91', 'Playlist1bZlX', '51');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlisttj2Aa', '3393064', '7/9/2022', '378', '77', 'Playlist4cbI5', '16');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistAChcU', '2777271', '3/2/2023', '208', '31', 'PlaylistFwxb1', '23');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistZP5q8', '6880608', '10/7/2022', '88', '85', 'PlaylisteuGS9', '53');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistXnYeK', '8456309', '2/22/2023', '118', '33', 'Playlistgzm5c', '92');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistcKbaO', '72619', '12/17/2022', '207', '22', 'PlaylistRxg52', '9');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistNonVy', '4274981', '4/17/2022', '180', '43', 'Playlistzmbdf', '76');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistHHd54', '382922', '2/11/2023', '8', '100', 'PlaylistvYR3f', '2');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistYU47P', '6063919', '1/8/2023', '25', '93', 'Playlistqxip8', '67');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistXoSn4', '1634431', '3/15/2023', '223', '82', 'PlaylistYZslo', '80');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist4xnXI', '2240427', '6/22/2022', '122', '45', 'Playlist0N8ax', '36');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistzBN4J', '6510629', '5/19/2022', '58', '98', 'PlaylistaeaL9', '97');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistb3Z8s', '3964267', '3/11/2023', '195', '23', 'PlaylistF0hvn', '42');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistTrh64', '9519699', '6/4/2022', '16', '49', 'PlaylistyKXGj', '70');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistQY05y', '7546293', '4/16/2022', '140', '22', 'PlaylistElr4Z', '86');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistRCuJv', '5917267', '12/30/2022', '309', '95', 'Playlist4GIz5', '28');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistT9XMx', '493023', '2/10/2023', '135', '82', 'PlaylistPPWsg', '11');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistIFXhr', '775180', '5/31/2022', '483', '77', 'PlaylistExw99', '77');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistFnJ7Y', '6850555', '3/7/2023', '384', '38', 'PlaylistYjHwm', '6');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistdDANX', '9691439', '8/20/2022', '106', '22', 'Playlistews3y', '2');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistOAPF1', '5570365', '4/30/2022', '262', '80', 'PlaylistTKagl', '3');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistsRr02', '9183865', '7/27/2022', '2', '22', 'PlaylistXt5l2', '52');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist1AOWu', '3255270', '3/26/2023', '71', '61', 'PlaylistKGRio', '93');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistm96vU', '621987', '12/27/2022', '208', '90', 'PlaylistbmKST', '30');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistqhNbK', '719594', '9/12/2022', '327', '8', 'PlaylistioFj4', '13');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistvX0Vj', '2035199', '11/12/2022', '51', '58', 'PlaylistTgnwD', '17');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistup3eP', '3983136', '8/16/2022', '478', '81', 'PlaylistAwS7V', '88');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistxLLVU', '753455', '4/27/2022', '260', '57', 'Playlist3QRA0', '93');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistRiqyl', '541607', '3/9/2023', '356', '22', 'Playlist5cBPG', '50');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistJ5g8x', '2163616', '9/24/2022', '241', '8', 'PlaylistwM2u3', '65');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistF2JR6', '7403286', '7/20/2022', '87', '55', 'PlaylisthbPWA', '92');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistQPAwE', '9695303', '11/2/2022', '72', '18', 'Playlisttdj0f', '50');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist0wzSN', '848614', '11/7/2022', '136', '3', 'Playlistlools', '53');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistuQaYk', '1610658', '4/6/2023', '258', '13', 'PlaylistSi6g0', '46');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistKWr4l', '5320479', '6/4/2022', '97', '29', 'Playlist01WyM', '68');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistWLTD2', '4118070', '9/25/2022', '16', '56', 'Playlistke1kL', '83');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistxyb5h', '5562059', '3/21/2023', '411', '33', 'PlaylistvxTWh', '46');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistWq1uO', '8961517', '2/27/2023', '24', '80', 'PlaylistINUGN', '47');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist1ur3m', '1422559', '7/23/2022', '332', '41', 'PlaylistfEwtN', '99');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistADvJH', '3885353', '4/8/2023', '461', '46', 'PlaylisteE1Jn', '33');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistTIqN1', '8671556', '2/26/2023', '378', '80', 'PlaylistEqeiv', '35');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistC08HZ', '210335', '7/3/2022', '156', '4', 'PlaylistQeJIz', '5');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist1PQUS', '2446983', '3/3/2023', '499', '42', 'PlaylistMpv0Y', '70');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist97THY', '3777331', '9/24/2022', '100', '93', 'PlaylistLt0FR', '55');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistEHYGF', '8282265', '5/20/2022', '136', '95', 'PlaylisthKzp0', '97');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistXEnIV', '6684424', '10/24/2022', '174', '24', 'PlaylistCkS9h', '21');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistYSxgr', '6073001', '4/17/2022', '304', '58', 'PlaylistHK6ph', '51');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistpGFNL', '7566837', '10/16/2022', '473', '59', 'Playlist1uCwF', '15');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist8I7B9', '5395799', '1/5/2023', '96', '65', 'PlaylistmdN4I', '44');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistITy7F', '5290688', '5/18/2022', '136', '96', 'Playlist1BSGB', '68');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistaE3l4', '1134932', '4/5/2023', '486', '31', 'PlaylistnWvUm', '32');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistdnFzQ', '4633326', '12/24/2022', '167', '84', 'PlaylistOpxsU', '85');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistxnwjv', '5121592', '8/3/2022', '39', '19', 'Playlistjb25J', '90');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistSY7Qd', '4550055', '1/16/2023', '458', '34', 'PlaylistdRBjC', '47');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistQGmxM', '9466473', '4/5/2023', '321', '27', 'PlaylistpjjZb', '79');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistp85pI', '9767292', '12/23/2022', '13', '8', 'PlaylistZ1AeO', '11');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylisthoTvF', '7305111', '1/8/2023', '142', '67', 'PlaylistbNgyS', '20');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistLtfvF', '4978797', '2/13/2023', '88', '48', 'PlaylistKoKEh', '46');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistZibJP', '8879324', '6/29/2022', '378', '52', 'PlaylistXd85h', '98');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistUDjUK', '4964559', '10/13/2022', '323', '78', 'PlaylistzJVP3', '88');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist3LJ6f', '34621', '5/7/2022', '334', '35', 'Playlistz9W4s', '66');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistv9diZ', '8678289', '4/18/2022', '423', '26', 'PlaylistxRm4F', '52');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistsuWBw', '3556591', '3/18/2023', '369', '89', 'PlaylistKPqek', '15');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistolmjW', '8211999', '1/24/2023', '225', '91', 'PlaylistVKpPT', '26');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistyFenj', '819939', '5/25/2022', '404', '92', 'PlaylistI0T78', '94');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist4FwDu', '1125765', '10/19/2022', '254', '37', 'PlaylistAPhy8', '69');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistfQr8t', '6216384', '1/18/2023', '163', '60', 'PlaylistldBUv', '76');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistcxGY9', '1972520', '4/17/2022', '250', '1', 'PlaylistGORjK', '39');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistcvSKV', '8287799', '2/3/2023', '323', '7', 'PlaylistBpqKy', '4');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistb0Zeo', '2079786', '7/15/2022', '300', '53', 'Playlist77Nmh', '3');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist5bvRW', '690647', '7/13/2022', '313', '17', 'PlaylistzTdf5', '29');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistBLtb9', '5591612', '12/7/2022', '282', '30', 'PlaylistiQabk', '88');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist1gAAR', '7790684', '6/14/2022', '346', '62', 'PlaylistB10U4', '34');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistC3aDv', '3160815', '7/4/2022', '94', '27', 'PlaylistXDEjP', '33');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistmLRg2', '1160060', '3/25/2023', '433', '39', 'PlaylistSJ35N', '84');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist0XMBG', '2428485', '10/22/2022', '358', '95', 'Playlist1lzCW', '60');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistPjXnC', '1009551', '10/21/2022', '117', '15', 'PlaylistX9Rfz', '63');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistG4YuZ', '9356600', '5/16/2022', '285', '100', 'PlaylistiY4Rm', '28');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlistfk1cZ', '292989', '1/3/2023', '72', '20', 'PlaylistqEf6S', '16');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistTizgc', '8973492', '4/17/2022', '304', '85', 'PlaylistjNzH2', '83');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlisti99HJ', '1424054', '4/10/2023', '374', '10', 'PlaylistUCoHW', '40');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistMpjqW', '3407550', '8/2/2022', '11', '12', 'PlaylistjlJXW', '2');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist2oBhr', '7442429', '9/19/2022', '260', '92', 'Playlistnuo1J', '66');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistGCfZd', '1838919', '5/4/2022', '359', '62', 'PlaylistTfuVM', '82');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistFHCKF', '3765695', '4/5/2023', '231', '23', 'PlaylistJOFS9', '81');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist4CDZj', '5298852', '9/1/2022', '92', '75', 'Playlist43p2E', '87');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('Playlist5PuoT', '8623958', '8/25/2022', '363', '66', 'PlaylistiNofc', '46');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistDOH3L', '8383063', '5/7/2022', '32', '98', 'PlaylistiVB62', '33');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistAoP6l', '3919492', '1/4/2023', '78', '20', 'PlaylistMsVfy', '37');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistIwgPj', '6637731', '1/16/2023', '333', '4', 'Playlist7MFXY', '35');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistdIJRv', '4119301', '3/14/2023', '353', '51', 'PlaylistXcYpl', '72');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistzWBYX', '6477956', '5/10/2022', '93', '13', 'PlaylistlILNo', '61');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistLF4pp', '3855462', '1/7/2023', '29', '60', 'PlaylistvHXZ5', '36');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistFFCpm', '9384465', '1/20/2023', '456', '17', 'Playlist6RLrG', '73');
INSERT INTO Playlists (name, likes, date_made, duration, episode_number, playlist_name, user_id) VALUES ('PlaylistHUnOu', '4996392', '2/14/2023', '285', '2', 'PlaylistIcpGE', '74');

--# Podcasts
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast231', '10/1/2022', '4052858', 'Adventure|Animation|Children|Drama', '50', '18');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast271', '2/11/2023', '7573403', 'Drama', '51', '5');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast997', '6/11/2022', '4469474', 'Drama', '16', '61');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast753', '1/5/2023', '6980570', 'Documentary', '66', '83');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast655', '10/22/2022', '2941026', 'Drama|Musical', '35', '43');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast527', '3/7/2023', '5379463', 'Drama', '31', '96');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast576', '8/7/2022', '5369367', 'Drama', '56', '73');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast857', '12/8/2022', '5902771', 'Comedy', '23', '4');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast423', '10/1/2022', '8247168', 'Documentary', '39', '92');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast847', '3/11/2023', '4793068', 'Comedy', '3', '55');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast517', '10/27/2022', '2601006', 'Crime', '25', '81');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast066', '6/19/2022', '6075694', 'Drama', '73', '30');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast651', '4/21/2022', '9120167', 'Adventure|Animation|Children|Drama|Fantasy', '21', '44');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast180', '3/17/2023', '2869185', 'Drama', '54', '59');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast582', '1/24/2023', '1094198', 'Drama', '83', '7');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast065', '6/10/2022', '2563738', 'Comedy|Drama', '77', '63');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast224', '3/20/2023', '1268762', 'Crime', '87', '62');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast015', '4/26/2022', '167898', 'Action|Drama', '29', '30');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast723', '5/19/2022', '3222776', 'Drama', '4', '37');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast357', '4/6/2023', '3828822', 'Comedy|Drama|Romance', '40', '58');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast533', '10/22/2022', '3167271', 'Drama', '77', '76');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast315', '8/27/2022', '2704578', 'Comedy|Romance', '31', '32');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast186', '11/17/2022', '9243786', 'Horror|Sci-Fi|Thriller', '46', '19');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast938', '4/21/2022', '7905472', 'Adventure', '15', '56');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast946', '1/25/2023', '5272937', 'Drama', '71', '53');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast239', '6/20/2022', '6412757', 'Adventure|Fantasy|Thriller', '18', '42');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast905', '6/5/2022', '4661777', 'Documentary', '82', '77');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast744', '5/21/2022', '4459267', 'Drama', '99', '58');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast236', '6/20/2022', '6189014', 'Horror|Sci-Fi|Thriller', '16', '24');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast899', '3/2/2023', '7995673', 'Drama', '62', '7');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast498', '4/19/2022', '3124262', 'Drama|War', '79', '76');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast928', '5/15/2022', '7287497', 'Drama|Musical|Romance', '15', '61');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast282', '12/14/2022', '5102857', 'Drama|Mystery|Sci-Fi|Thriller', '77', '15');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast012', '11/24/2022', '5212915', 'Action|Horror|Sci-Fi|Thriller', '21', '18');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast039', '8/12/2022', '6149873', 'Crime|Drama', '1', '54');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast519', '12/11/2022', '4712664', 'Fantasy|Horror|Thriller', '47', '68');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast018', '5/10/2022', '2712621', 'Action|Animation|Children|Sci-Fi', '71', '13');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast202', '9/9/2022', '87928', 'Drama|Musical|Romance', '61', '67');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast806', '4/4/2023', '8073071', 'Drama', '58', '63');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast929', '5/19/2022', '7876466', 'Action|Horror|Sci-Fi|Thriller', '89', '92');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast783', '5/22/2022', '6452993', 'Comedy|Drama', '28', '71');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast678', '12/31/2022', '5520406', 'Drama', '56', '45');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast647', '9/30/2022', '1905081', 'Drama', '13', '69');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast753', '6/2/2022', '530413', 'Drama|Mystery|Sci-Fi|Thriller', '20', '63');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast438', '9/4/2022', '209311', 'Drama|Romance', '65', '60');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast252', '11/9/2022', '1873721', 'Action|Drama', '6', '49');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast934', '2/21/2023', '8740537', 'Drama', '14', '17');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast146', '1/11/2023', '9039027', 'Mystery', '98', '71');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast430', '4/6/2023', '8927134', 'Comedy|Sci-Fi', '8', '4');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast290', '11/11/2022', '5680749', 'Comedy|Drama', '56', '38');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast643', '12/3/2022', '5528907', 'Comedy|Drama', '32', '97');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast467', '7/6/2022', '3744612', 'Drama|Horror|Romance', '73', '87');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast970', '2/1/2023', '2086901', 'Adventure|Animation|Children|Drama', '31', '6');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast045', '12/2/2022', '6223935', 'Comedy|Drama', '35', '45');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast293', '3/6/2023', '2270355', 'Drama|Romance|War', '67', '59');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast331', '3/20/2023', '3533007', 'Comedy', '29', '92');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast648', '2/7/2023', '6705430', 'Comedy|Drama|Romance', '28', '77');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast117', '6/15/2022', '5832118', 'Crime|Drama|Film-Noir|Thriller', '90', '99');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast001', '4/3/2023', '5309851', 'Comedy', '17', '62');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast384', '8/19/2022', '5621416', 'Drama|War', '99', '55');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast937', '2/18/2023', '6168827', 'Drama|Musical', '81', '73');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast350', '2/27/2023', '97972', 'Drama', '56', '55');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast006', '6/2/2022', '1369319', 'Drama', '100', '50');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast203', '2/13/2023', '2034337', '(no genres listed)', '55', '5');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast302', '6/7/2022', '9023968', 'Comedy', '77', '13');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast755', '8/10/2022', '537789', 'Horror|Sci-Fi', '63', '55');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast934', '2/27/2023', '1044930', 'Drama', '90', '75');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast339', '4/29/2022', '194253', 'Horror|Sci-Fi|Thriller', '31', '30');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast525', '7/22/2022', '3967653', 'Drama|Romance', '93', '37');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast703', '8/30/2022', '306121', 'Comedy', '78', '89');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast950', '12/19/2022', '7211762', 'Animation|Children|Fantasy', '43', '55');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast237', '11/5/2022', '4302872', 'Drama', '35', '53');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast369', '9/12/2022', '5551278', 'Comedy|Romance', '99', '40');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast117', '6/14/2022', '3848287', 'Comedy|Crime', '56', '4');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast829', '10/28/2022', '9400801', 'Drama', '91', '65');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast432', '6/4/2022', '1001079', 'Drama', '91', '66');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast134', '3/30/2023', '7613319', 'Drama|Mystery', '81', '63');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast656', '3/17/2023', '236066', 'Comedy|Romance', '87', '26');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast682', '2/2/2023', '4837096', 'Drama|Romance', '9', '54');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast251', '2/24/2023', '5449735', 'Drama|War', '12', '95');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast480', '9/1/2022', '7435166', 'Comedy|Romance', '81', '89');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast112', '11/24/2022', '4117886', 'Documentary', '42', '77');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast858', '4/16/2022', '613936', 'Drama', '19', '21');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast810', '5/28/2022', '6784408', 'Drama', '65', '73');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast176', '8/8/2022', '6462468', 'Crime|Drama', '71', '87');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast292', '9/29/2022', '4634984', 'Drama|Romance', '50', '90');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast555', '2/1/2023', '6876716', 'Comedy', '34', '13');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast793', '1/15/2023', '4982556', 'Action|Sci-Fi|War', '76', '28');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast583', '10/23/2022', '4896525', 'Documentary', '45', '62');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast737', '1/25/2023', '7673435', 'Comedy', '56', '32');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast726', '9/21/2022', '5303487', 'Drama|Romance', '17', '18');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast009', '7/15/2022', '8331240', 'Action|Animation|Children|Sci-Fi', '37', '100');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast167', '11/11/2022', '3871459', 'Drama', '29', '51');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast272', '9/22/2022', '235643', 'Drama|Mystery', '78', '4');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast290', '6/5/2022', '1625913', 'Action|Comedy|Thriller', '98', '65');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast802', '9/30/2022', '1900650', 'Drama', '10', '48');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast464', '11/14/2022', '1710734', 'Action|Sci-Fi|Thriller', '16', '99');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast662', '11/8/2022', '1847757', 'Action|Animation|Comedy', '36', '69');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast899', '6/28/2022', '7495549', 'Crime|Drama|Film-Noir|Thriller', '100', '86');
INSERT INTO Podcasts (name, release_date, number_of_episodes, genre_name, episode_number, creator_id) VALUES ('Podcast987', '3/24/2023', '7916793', 'Horror|Mystery|Thriller', '70', '23');

--# Statistics
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('96', '8148017', '3019233', '9451678', '3250148');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('3', '3800859', '6163241', '28515', '1260558');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('48', '2252531', '7852114', '950268', '4383920');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('68', '2383681', '8013411', '9579188', '8943960');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('41', '5706153', '2771361', '1715746', '8254567');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('54', '2253168', '994587', '6199084', '618856');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('56', '2472011', '5379303', '6194716', '7894256');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('97', '6226507', '2250133', '821894', '2649812');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('8', '216575', '1885302', '8177827', '9994889');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('81', '7911413', '7227395', '4368254', '9032266');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('53', '9177908', '5249270', '4816760', '2271086');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('26', '8871243', '3422247', '1130724', '83483');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('10', '6661326', '9287213', '5897167', '6630779');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('44', '6242680', '6389914', '9953571', '5577696');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('59', '7176758', '1399998', '8191440', '4659220');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('97', '4915638', '5563951', '6588946', '7391864');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('76', '8674455', '9745580', '1461914', '2013924');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('68', '8190907', '8754764', '8553075', '404728');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('65', '4336893', '8745084', '4289768', '1734684');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('48', '4979892', '1403409', '5665397', '591599');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('11', '8261622', '1859635', '2836459', '5153198');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('64', '5853432', '3666909', '3973467', '8217319');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('26', '3275408', '4848743', '5727788', '2287091');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('6', '5482377', '5855755', '8126444', '7148888');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('43', '2350486', '8498644', '9333252', '5530602');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('57', '1038987', '6930445', '3591752', '4058839');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('66', '8545567', '3812222', '6324556', '3276169');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('67', '7643520', '1123849', '8301735', '5160099');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('30', '91023', '6047459', '1338384', '7915823');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('63', '212798', '1919773', '9187866', '7839565');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('87', '5218949', '5049650', '4498389', '6485410');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('29', '3754341', '8337377', '7053924', '4605533');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('28', '9788777', '786105', '7371225', '7977002');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('63', '302324', '682005', '861733', '918695');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('58', '2987053', '8368895', '6740435', '1542473');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('78', '7523461', '5839820', '5975234', '5597375');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('20', '4793046', '8884215', '8999302', '3946463');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('11', '5989913', '4907801', '1998566', '2980402');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('59', '465682', '2828236', '6365468', '2799834');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('88', '2010011', '8915364', '4590555', '1543916');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('56', '7469389', '3114788', '7049276', '5720003');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('82', '2444550', '4569388', '3777547', '6942082');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('62', '5296524', '6220436', '4836249', '6899771');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('55', '3163260', '5426762', '5103648', '3350043');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('90', '4518627', '5269611', '5113946', '9387993');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('97', '6793157', '5734346', '1472642', '5622834');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('83', '6241875', '9935675', '786845', '6461318');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('86', '6289598', '4105521', '9630145', '1663737');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('7', '6405165', '2190692', '2145112', '8012167');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('66', '351237', '4148966', '237675', '1806425');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('80', '2907189', '5262259', '3740775', '9591209');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('96', '5324422', '6767939', '6163397', '4798587');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('69', '1940850', '192597', '4199071', '1634860');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('58', '848810', '3100535', '9124277', '9908063');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('93', '9600396', '3878021', '3296698', '7787091');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('36', '4747372', '6198862', '2293105', '1466087');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('69', '1229081', '7146680', '1527724', '2925748');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('89', '4549427', '9668040', '9537618', '9085580');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('13', '7100344', '8486782', '1746929', '5129121');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('96', '3436285', '1895871', '6153784', '3107615');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('82', '5172325', '2769756', '5419354', '7001072');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('94', '8815112', '6941032', '4711649', '8967398');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('63', '8771175', '4913342', '7775539', '8175866');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('35', '6804798', '1925378', '7452938', '2594032');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('73', '4906314', '9538931', '9293155', '6125570');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('24', '5806222', '8865685', '6554985', '9619978');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('76', '3419578', '2338227', '8574294', '1148739');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('77', '6168172', '587550', '1484524', '5885226');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('66', '1553425', '5364408', '9810835', '6035437');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('82', '2911246', '9875038', '356481', '3963204');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('86', '8100072', '3740554', '5710195', '2543769');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('75', '875129', '8274090', '6910893', '7237677');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('43', '9884700', '8522635', '3705097', '6288960');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('95', '6956375', '3364291', '8267886', '6750688');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('81', '7599612', '5641870', '6557290', '1424315');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('63', '3981002', '6517911', '8106181', '3421032');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('17', '8914764', '3457030', '9839013', '1306692');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('75', '7671396', '8160284', '67111', '3340774');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('87', '1664907', '9283044', '4765466', '8053380');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('54', '8357449', '5100762', '5702002', '9304049');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('99', '5953561', '9307557', '9151746', '3329118');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('69', '487050', '5634958', '2935631', '5063585');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('68', '3787852', '9923222', '824712', '3483419');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('55', '8311463', '6095446', '1995514', '6265011');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('34', '5762613', '982035', '1522605', '6285396');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('10', '1595282', '9246198', '6366105', '450552');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('85', '2245495', '183177', '6534004', '9774629');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('27', '5953212', '5912162', '5595497', '4138920');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('47', '8181124', '4121048', '1179199', '9070139');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('67', '6406941', '3113314', '6768003', '9399419');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('24', '3543050', '7724350', '7370408', '3884452');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('2', '5966594', '1748968', '2844719', '3877931');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('51', '4934085', '6184134', '2404972', '4749238');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('42', '5688252', '1685283', '1838699', '6217584');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('65', '9145119', '4267994', '1545182', '8707163');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('88', '2540836', '374003', '4621373', '1192003');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('76', '8783007', '7229668', '2568633', '6215481');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('90', '2584883', '6910402', '1774528', '2051837');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('25', '5222555', '2211615', '2529154', '7963609');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('13', '4481846', '9828053', '1330645', '6342750');

--# Suppliers
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('1', '65', 'Ridgeway', 'Jackson', 'Mississippi', '39296');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('2', '7', 'Dottie', 'New Orleans', 'Louisiana', '70187');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('3', '27', 'Old Gate', 'Kansas City', 'Missouri', '64187');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('4', '52', 'Hovde', 'Salt Lake City', 'Utah', '84130');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('5', '59', 'Scott', 'Gary', 'Indiana', '46406');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('6', '98', 'Bellgrove', 'Augusta', 'Georgia', '30919');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('7', '71', 'Leroy', 'Des Moines', 'Iowa', '50347');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('8', '6', 'Lotheville', 'Salem', 'Oregon', '97312');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('9', '72', 'Bay', 'Springfield', 'Illinois', '62723');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('10', '52', 'Florence', 'Honolulu', 'Hawaii', '96820');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('11', '94', 'Mccormick', 'Long Beach', 'California', '90810');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('12', '78', 'Kings', 'Pittsburgh', 'Pennsylvania', '15274');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('13', '29', 'Mayer', 'Phoenix', 'Arizona', '85053');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('14', '43', 'Lindbergh', 'Carol Stream', 'Illinois', '60158');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('15', '98', 'Clove', 'Honolulu', 'Hawaii', '96805');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('16', '35', 'Myrtle', 'Springfield', 'Illinois', '62794');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('17', '92', 'Hermina', 'New Haven', 'Connecticut', '06510');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('18', '42', 'Surrey', 'Hot Springs National Park', 'Arkansas', '71914');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('19', '87', 'Calypso', 'Los Angeles', 'California', '90005');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('20', '12', 'Westend', 'Panama City', 'Florida', '32412');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('21', '16', 'Sachtjen', 'Oklahoma City', 'Oklahoma', '73152');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('22', '80', 'Troy', 'Odessa', 'Texas', '79769');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('23', '10', 'Miller', 'Philadelphia', 'Pennsylvania', '19146');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('24', '68', 'Jackson', 'Austin', 'Texas', '78764');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('25', '9', 'Anniversary', 'Shreveport', 'Louisiana', '71130');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('26', '8', 'Superior', 'Austin', 'Texas', '78789');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('27', '41', 'Moulton', 'Scranton', 'Pennsylvania', '18505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('28', '18', 'Jay', 'Southfield', 'Michigan', '48076');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('29', '72', 'Dapin', 'Minneapolis', 'Minnesota', '55417');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('30', '23', 'Rusk', 'Pensacola', 'Florida', '32526');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('31', '71', 'Lighthouse Bay', 'Denver', 'Colorado', '80235');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('32', '97', 'Golf View', 'Saint Paul', 'Minnesota', '55172');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('33', '79', 'Tomscot', 'Fort Lauderdale', 'Florida', '33330');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('34', '95', 'Fremont', 'Tyler', 'Texas', '75710');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('35', '91', 'Harper', 'Fresno', 'California', '93762');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('36', '82', 'Sloan', 'Amarillo', 'Texas', '79182');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('37', '35', 'Helena', 'Lake Charles', 'Louisiana', '70616');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('38', '25', '8th', 'Pasadena', 'California', '91117');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('39', '56', 'Crowley', 'Dallas', 'Texas', '75397');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('40', '36', 'Cottonwood', 'Lake Worth', 'Florida', '33467');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('41', '28', 'Hanover', 'Norwalk', 'Connecticut', '06859');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('42', '42', 'Tony', 'El Paso', 'Texas', '88546');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('43', '1', 'Manitowish', 'Indianapolis', 'Indiana', '46216');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('44', '50', 'East', 'Redwood City', 'California', '94064');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('45', '56', 'Hanover', 'Savannah', 'Georgia', '31410');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('46', '70', 'Dexter', 'San Jose', 'California', '95194');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('47', '73', 'Sloan', 'Van Nuys', 'California', '91411');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('48', '34', 'Golf', 'Colorado Springs', 'Colorado', '80910');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('49', '44', 'Vernon', 'Houston', 'Texas', '77070');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('50', '59', 'Arizona', 'Garland', 'Texas', '75049');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('51', '37', 'Hermina', 'Tulsa', 'Oklahoma', '74193');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('52', '60', 'Clove', 'Columbus', 'Ohio', '43204');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('53', '55', 'Wayridge', 'Spokane', 'Washington', '99252');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('54', '51', 'Harper', 'San Jose', 'California', '95133');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('55', '50', 'Sheridan', 'Boise', 'Idaho', '83727');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('56', '73', 'Troy', 'Trenton', 'New Jersey', '08638');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('57', '24', 'Emmet', 'Albuquerque', 'New Mexico', '87195');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('58', '32', 'New Castle', 'Sacramento', 'California', '95828');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('59', '6', 'Rockefeller', 'Sacramento', 'California', '94207');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('60', '26', 'Crescent Oaks', 'Montgomery', 'Alabama', '36195');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('61', '38', 'Katie', 'Bronx', 'New York', '10459');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('62', '71', 'Thierer', 'Washington', 'District of Columbia', '20260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('63', '75', 'Brentwood', 'Baton Rouge', 'Louisiana', '70815');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('64', '14', 'Hoard', 'Los Angeles', 'California', '90035');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('65', '30', 'Sheridan', 'Saint Paul', 'Minnesota', '55172');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('66', '95', 'Independence', 'Brooklyn', 'New York', '11236');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('67', '57', 'Judy', 'San Diego', 'California', '92191');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('68', '38', 'Elgar', 'Washington', 'District of Columbia', '56944');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('69', '13', 'Vermont', 'Van Nuys', 'California', '91411');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('70', '9', 'Fairfield', 'Shreveport', 'Louisiana', '71161');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('71', '38', '7th', 'Richmond', 'Virginia', '23260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('72', '9', 'Lindbergh', 'Sterling', 'Virginia', '20167');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('73', '48', 'Village', 'Fort Collins', 'Colorado', '80525');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('74', '54', 'Maple Wood', 'San Francisco', 'California', '94177');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('75', '95', 'Pond', 'Charleston', 'West Virginia', '25331');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('76', '76', 'Kedzie', 'Tucson', 'Arizona', '85705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('77', '63', 'Mariners Cove', 'Kansas City', 'Missouri', '64142');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('78', '6', 'Dorton', 'Oklahoma City', 'Oklahoma', '73190');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('79', '31', 'Blue Bill Park', 'Houston', 'Texas', '77218');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('80', '22', 'Arkansas', 'Reading', 'Pennsylvania', '19610');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('81', '67', '3rd', 'Las Vegas', 'Nevada', '89110');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('82', '57', 'Colorado', 'Wilmington', 'Delaware', '19897');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('83', '39', 'Banding', 'Bronx', 'New York', '10464');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('84', '20', 'Merchant', 'Montgomery', 'Alabama', '36109');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('85', '98', 'School', 'Helena', 'Montana', '59623');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('86', '39', 'Delladonna', 'Clearwater', 'Florida', '33758');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('87', '80', 'Longview', 'Cleveland', 'Ohio', '44197');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('88', '6', 'Meadow Ridge', 'Saint Petersburg', 'Florida', '33715');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('89', '23', 'Dorton', 'Pasadena', 'California', '91109');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('90', '21', 'High Crossing', 'Austin', 'Texas', '78783');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('91', '60', 'Basil', 'Huntington Beach', 'California', '92648');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('92', '21', 'Rockefeller', 'Decatur', 'Illinois', '62525');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('93', '94', 'Dapin', 'New York City', 'New York', '10175');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('94', '90', 'Hermina', 'San Diego', 'California', '92176');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('95', '71', 'Pennsylvania', 'Wichita', 'Kansas', '67220');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('96', '17', 'Hermina', 'Denver', 'Colorado', '80243');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('97', '11', 'Springs', 'Columbus', 'Ohio', '43210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('98', '42', 'Hudson', 'Pensacola', 'Florida', '32526');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('99', '86', 'Bluestem', 'Cumming', 'Georgia', '30130');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('100', '99', 'Fordem', 'Atlanta', 'Georgia', '30368');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('101', '38', 'Chinook', 'Evansville', 'Indiana', '47732');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('102', '86', 'Dunning', 'Springfield', 'Virginia', '22156');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('103', '45', 'Stone Corner', 'Amarillo', 'Texas', '79182');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('104', '33', 'Raven', 'Tacoma', 'Washington', '98417');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('105', '21', 'Redwing', 'Birmingham', 'Alabama', '35290');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('106', '34', 'Carberry', 'Denver', 'Colorado', '80235');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('107', '31', 'Sauthoff', 'Los Angeles', 'California', '90071');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('108', '30', 'Washington', 'Syracuse', 'New York', '13205');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('109', '4', 'Scoville', 'Fredericksburg', 'Virginia', '22405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('110', '82', 'Bellgrove', 'Sarasota', 'Florida', '34238');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('111', '61', 'Spohn', 'Lexington', 'Kentucky', '40591');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('112', '45', 'Vidon', 'New York City', 'New York', '10099');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('113', '26', 'Charing Cross', 'Alexandria', 'Louisiana', '71307');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('114', '54', 'Hoard', 'Columbia', 'South Carolina', '29203');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('115', '3', 'Service', 'Louisville', 'Kentucky', '40233');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('116', '10', 'Veith', 'Saint Louis', 'Missouri', '63167');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('117', '1', 'Dayton', 'Charleston', 'West Virginia', '25321');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('118', '90', 'Mcbride', 'New Haven', 'Connecticut', '06520');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('119', '2', 'Dayton', 'Spokane', 'Washington', '99210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('120', '62', 'Dexter', 'Glendale', 'Arizona', '85305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('121', '94', 'Granby', 'Jamaica', 'New York', '11436');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('122', '10', 'Haas', 'Saint Joseph', 'Missouri', '64504');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('123', '92', 'Sachtjen', 'Denver', 'Colorado', '80204');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('124', '68', 'Anderson', 'Santa Cruz', 'California', '95064');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('125', '69', 'Scofield', 'Memphis', 'Tennessee', '38197');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('126', '53', 'Heffernan', 'Concord', 'California', '94522');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('127', '91', 'Dunning', 'Tampa', 'Florida', '33633');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('128', '78', 'Upham', 'San Diego', 'California', '92176');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('129', '82', 'South', 'Springfield', 'Illinois', '62723');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('130', '55', 'Buhler', 'San Antonio', 'Texas', '78215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('131', '96', 'Fremont', 'Palmdale', 'California', '93591');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('132', '32', 'Ryan', 'Washington', 'District of Columbia', '20310');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('133', '21', 'Londonderry', 'San Bernardino', 'California', '92405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('134', '74', 'Bay', 'Macon', 'Georgia', '31296');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('135', '73', 'Bowman', 'Athens', 'Georgia', '30610');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('136', '46', 'Dryden', 'Greenville', 'South Carolina', '29615');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('137', '41', 'Harbort', 'Dayton', 'Ohio', '45419');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('138', '14', 'Eagle Crest', 'Providence', 'Rhode Island', '02912');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('139', '84', 'Lunder', 'Reno', 'Nevada', '89519');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('140', '1', 'Linden', 'Beaverton', 'Oregon', '97075');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('141', '66', '4th', 'Bloomington', 'Illinois', '61709');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('142', '27', 'Lukken', 'Athens', 'Georgia', '30610');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('143', '28', 'Carpenter', 'Orlando', 'Florida', '32885');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('144', '5', 'Butternut', 'Waterbury', 'Connecticut', '06721');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('145', '7', 'Banding', 'Bronx', 'New York', '10454');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('146', '41', 'Gina', 'Memphis', 'Tennessee', '38197');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('147', '13', 'La Follette', 'Terre Haute', 'Indiana', '47805');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('148', '73', 'Hallows', 'Montgomery', 'Alabama', '36125');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('149', '41', 'South', 'Orlando', 'Florida', '32868');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('150', '81', 'Goodland', 'Wilmington', 'North Carolina', '28410');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('151', '20', 'Waxwing', 'Washington', 'District of Columbia', '20036');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('152', '90', 'Randy', 'Rochester', 'Minnesota', '55905');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('153', '1', 'Stuart', 'Vero Beach', 'Florida', '32969');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('154', '33', 'Anthes', 'Hamilton', 'Ohio', '45020');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('155', '51', 'Loftsgordon', 'Madison', 'Wisconsin', '53785');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('156', '42', 'Mandrake', 'Orlando', 'Florida', '32830');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('157', '77', 'Transport', 'Colorado Springs', 'Colorado', '80951');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('158', '7', 'Glacier Hill', 'Charlotte', 'North Carolina', '28278');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('159', '61', 'Bultman', 'Killeen', 'Texas', '76544');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('160', '98', 'Mariners Cove', 'Albany', 'New York', '12227');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('161', '70', 'Bunker Hill', 'Dayton', 'Ohio', '45426');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('162', '71', 'Texas', 'Kalamazoo', 'Michigan', '49006');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('163', '70', 'Ronald Regan', 'Reading', 'Pennsylvania', '19605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('164', '28', 'Pond', 'Tucson', 'Arizona', '85715');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('165', '16', 'Ridgeway', 'Colorado Springs', 'Colorado', '80925');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('166', '26', 'Lukken', 'Tyler', 'Texas', '75710');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('167', '46', 'Kingsford', 'Oklahoma City', 'Oklahoma', '73152');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('168', '76', 'Sutherland', 'Stockton', 'California', '95210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('169', '75', 'Mendota', 'San Antonio', 'Texas', '78220');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('170', '8', 'Vermont', 'Washington', 'District of Columbia', '20073');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('171', '98', 'Nelson', 'Fairbanks', 'Alaska', '99709');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('172', '13', 'Chinook', 'Humble', 'Texas', '77346');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('173', '29', 'Arrowood', 'Baton Rouge', 'Louisiana', '70820');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('174', '42', 'Hollow Ridge', 'Memphis', 'Tennessee', '38181');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('175', '5', 'Orin', 'Austin', 'Texas', '78726');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('176', '80', 'Cody', 'Fresno', 'California', '93704');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('177', '13', 'Muir', 'Charlotte', 'North Carolina', '28235');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('178', '36', 'Main', 'North Hollywood', 'California', '91606');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('179', '20', 'Rigney', 'Houston', 'Texas', '77045');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('180', '38', 'Buhler', 'Appleton', 'Wisconsin', '54915');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('181', '97', 'Cambridge', 'Fort Wayne', 'Indiana', '46825');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('182', '41', 'Jenna', 'Bloomington', 'Illinois', '61709');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('183', '42', 'Reindahl', 'Savannah', 'Georgia', '31422');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('184', '10', 'Paget', 'Jefferson City', 'Missouri', '65110');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('185', '33', 'Barby', 'Omaha', 'Nebraska', '68124');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('186', '63', 'Sloan', 'Indianapolis', 'Indiana', '46207');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('187', '99', 'Clarendon', 'Houston', 'Texas', '77260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('188', '38', 'Loftsgordon', 'Madison', 'Wisconsin', '53785');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('189', '96', 'Warner', 'Akron', 'Ohio', '44305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('190', '12', '7th', 'San Diego', 'California', '92191');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('191', '28', 'Florence', 'Winston Salem', 'North Carolina', '27105');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('192', '65', 'Scoville', 'Reno', 'Nevada', '89550');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('193', '37', 'Service', 'Dallas', 'Texas', '75205');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('194', '65', 'Raven', 'Tucson', 'Arizona', '85710');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('195', '16', 'Fallview', 'Palm Bay', 'Florida', '32909');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('196', '45', 'Manitowish', 'Spokane', 'Washington', '99205');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('197', '84', 'Welch', 'Washington', 'District of Columbia', '20260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('198', '21', 'Lake View', 'Shawnee Mission', 'Kansas', '66225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('199', '53', 'Dawn', 'Louisville', 'Kentucky', '40225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('200', '74', 'Melvin', 'Los Angeles', 'California', '90045');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('201', '33', 'Crescent Oaks', 'Minneapolis', 'Minnesota', '55436');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('202', '69', 'Larry', 'Omaha', 'Nebraska', '68105');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('203', '72', 'Harbort', 'Saint Louis', 'Missouri', '63143');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('204', '83', 'Maywood', 'Miami', 'Florida', '33153');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('205', '59', 'Corry', 'San Luis Obispo', 'California', '93407');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('206', '77', 'Butterfield', 'Washington', 'District of Columbia', '20370');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('207', '27', 'Cody', 'Joliet', 'Illinois', '60435');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('208', '37', 'Memorial', 'Fort Smith', 'Arkansas', '72916');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('209', '2', 'International', 'Chico', 'California', '95973');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('210', '25', 'Acker', 'Los Angeles', 'California', '90055');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('211', '99', 'Kim', 'Durham', 'North Carolina', '27705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('212', '41', 'Scoville', 'Oceanside', 'California', '92056');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('213', '7', 'Continental', 'Reno', 'Nevada', '89550');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('214', '10', 'Autumn Leaf', 'New York City', 'New York', '10270');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('215', '76', 'Oriole', 'San Jose', 'California', '95113');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('216', '94', 'Algoma', 'Los Angeles', 'California', '90015');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('217', '6', 'Jenna', 'Tulsa', 'Oklahoma', '74170');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('218', '27', 'Pearson', 'Fargo', 'North Dakota', '58122');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('219', '69', 'Sullivan', 'Youngstown', 'Ohio', '44511');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('220', '10', 'Blue Bill Park', 'Panama City', 'Florida', '32412');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('221', '36', 'Utah', 'Johnson City', 'Tennessee', '37605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('222', '58', 'Express', 'Chattanooga', 'Tennessee', '37450');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('223', '48', 'Sommers', 'Atlanta', 'Georgia', '30368');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('224', '78', 'Fallview', 'Rochester', 'New York', '14609');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('225', '92', 'Ramsey', 'Spokane', 'Washington', '99252');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('226', '9', 'Riverside', 'Clearwater', 'Florida', '34629');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('227', '98', 'Stone Corner', 'Jacksonville', 'Florida', '32259');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('228', '53', 'South', 'Atlanta', 'Georgia', '31132');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('229', '80', 'Waxwing', 'Columbus', 'Ohio', '43240');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('230', '61', 'Bonner', 'Troy', 'Michigan', '48098');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('231', '80', 'Waywood', 'Cumming', 'Georgia', '30130');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('232', '21', 'Oak Valley', 'Mobile', 'Alabama', '36628');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('233', '5', 'Utah', 'Daytona Beach', 'Florida', '32118');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('234', '81', 'Cody', 'Fort Lauderdale', 'Florida', '33305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('235', '1', 'Bellgrove', 'New Haven', 'Connecticut', '06505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('236', '41', 'Hooker', 'Washington', 'District of Columbia', '20397');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('237', '21', 'Vera', 'Washington', 'District of Columbia', '20456');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('238', '76', 'Dexter', 'Houston', 'Texas', '77260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('239', '20', 'Sachs', 'Naples', 'Florida', '33963');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('240', '100', 'Upham', 'Lansing', 'Michigan', '48956');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('241', '16', 'Stone Corner', 'Roanoke', 'Virginia', '24004');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('242', '65', 'Kedzie', 'Cape Coral', 'Florida', '33915');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('243', '33', 'Brentwood', 'Miami', 'Florida', '33233');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('244', '97', 'Elgar', 'Santa Cruz', 'California', '95064');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('245', '17', 'Laurel', 'Kansas City', 'Missouri', '64142');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('246', '7', 'Corscot', 'Kansas City', 'Missouri', '64153');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('247', '93', 'Memorial', 'Tacoma', 'Washington', '98442');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('248', '54', 'Troy', 'Los Angeles', 'California', '90005');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('249', '78', 'Kedzie', 'Denver', 'Colorado', '80217');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('250', '36', 'Mariners Cove', 'Pinellas Park', 'Florida', '34665');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('251', '53', 'Claremont', 'New York City', 'New York', '10009');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('252', '7', 'Erie', 'Brooklyn', 'New York', '11210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('253', '12', 'Village Green', 'Tacoma', 'Washington', '98411');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('254', '14', 'Butterfield', 'Denver', 'Colorado', '80228');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('255', '77', 'Veith', 'Phoenix', 'Arizona', '85025');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('256', '84', 'Daystar', 'Dallas', 'Texas', '75221');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('257', '63', 'Barby', 'Louisville', 'Kentucky', '40225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('258', '5', 'Ridgeview', 'New Brunswick', 'New Jersey', '08922');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('259', '45', 'Susan', 'Modesto', 'California', '95354');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('260', '18', 'Independence', 'San Mateo', 'California', '94405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('261', '76', 'Macpherson', 'Kent', 'Washington', '98042');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('262', '53', 'Eastlawn', 'Carol Stream', 'Illinois', '60158');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('263', '11', 'Ludington', 'Miami', 'Florida', '33245');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('264', '4', 'Packers', 'Portsmouth', 'New Hampshire', '03804');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('265', '82', 'Old Shore', 'Bronx', 'New York', '10454');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('266', '19', 'Caliangt', 'Tempe', 'Arizona', '85284');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('267', '71', 'Northridge', 'Boca Raton', 'Florida', '33487');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('268', '47', 'Lighthouse Bay', 'Columbus', 'Ohio', '43204');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('269', '52', 'Emmet', 'Dallas', 'Texas', '75323');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('270', '7', 'Kim', 'Las Vegas', 'Nevada', '89150');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('271', '92', 'Eastwood', 'Philadelphia', 'Pennsylvania', '19172');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('272', '26', 'Little Fleur', 'Fairfax', 'Virginia', '22036');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('273', '40', 'Spaight', 'Milwaukee', 'Wisconsin', '53277');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('274', '98', 'Ohio', 'Cincinnati', 'Ohio', '45208');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('275', '11', 'Swallow', 'Charleston', 'West Virginia', '25326');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('276', '58', 'Lakeland', 'Saint Cloud', 'Minnesota', '56372');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('277', '14', 'Scofield', 'Elizabeth', 'New Jersey', '07208');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('278', '72', 'Luster', 'El Paso', 'Texas', '88574');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('279', '21', 'Monica', 'New York City', 'New York', '10079');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('280', '93', 'Rieder', 'Akron', 'Ohio', '44321');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('281', '81', 'Bowman', 'Louisville', 'Kentucky', '40256');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('282', '52', 'Katie', 'Springfield', 'Illinois', '62776');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('283', '24', 'Sauthoff', 'Murfreesboro', 'Tennessee', '37131');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('284', '34', 'Larry', 'Boise', 'Idaho', '83727');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('285', '26', 'Mitchell', 'Portsmouth', 'New Hampshire', '00214');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('286', '33', 'Scoville', 'Birmingham', 'Alabama', '35279');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('287', '81', 'Hauk', 'Reno', 'Nevada', '89510');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('288', '39', 'Barnett', 'Atlanta', 'Georgia', '30386');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('289', '89', 'Londonderry', 'Louisville', 'Kentucky', '40215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('290', '20', 'Fair Oaks', 'San Jose', 'California', '95160');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('291', '88', 'Elka', 'Charlotte', 'North Carolina', '28230');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('292', '28', 'Butternut', 'Pompano Beach', 'Florida', '33064');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('293', '48', 'Amoth', 'Youngstown', 'Ohio', '44511');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('294', '18', 'Scofield', 'Ogden', 'Utah', '84403');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('295', '70', 'Dwight', 'Boise', 'Idaho', '83705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('296', '34', 'Marquette', 'Salt Lake City', 'Utah', '84125');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('297', '48', 'Truax', 'Newton', 'Massachusetts', '02458');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('298', '78', 'Linden', 'Honolulu', 'Hawaii', '96805');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('299', '63', 'Butterfield', 'Charleston', 'West Virginia', '25336');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('300', '17', 'Tony', 'Colorado Springs', 'Colorado', '80920');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('301', '92', 'Spohn', 'Monroe', 'Louisiana', '71208');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('302', '7', 'Hayes', 'Fayetteville', 'North Carolina', '28305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('303', '13', 'Burning Wood', 'Indianapolis', 'Indiana', '46226');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('304', '17', 'Algoma', 'Tampa', 'Florida', '33680');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('305', '69', 'Browning', 'El Paso', 'Texas', '88553');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('306', '63', 'Garrison', 'Honolulu', 'Hawaii', '96805');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('307', '100', 'Dayton', 'Kansas City', 'Missouri', '64144');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('308', '72', 'Stoughton', 'New York City', 'New York', '10014');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('309', '85', 'Northport', 'Minneapolis', 'Minnesota', '55436');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('310', '59', 'Packers', 'San Bernardino', 'California', '92410');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('311', '96', 'Eastwood', 'Akron', 'Ohio', '44315');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('312', '9', 'Mendota', 'Springfield', 'Missouri', '65810');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('313', '82', 'Mockingbird', 'Indianapolis', 'Indiana', '46226');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('314', '94', 'Burrows', 'Minneapolis', 'Minnesota', '55412');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('315', '23', 'Sunfield', 'Charlotte', 'North Carolina', '28263');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('316', '70', 'Truax', 'Houston', 'Texas', '77025');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('317', '67', 'Esch', 'Tucson', 'Arizona', '85715');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('318', '31', 'Old Shore', 'Great Neck', 'New York', '11024');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('319', '17', 'Carberry', 'San Diego', 'California', '92165');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('320', '68', 'Hoepker', 'Columbus', 'Ohio', '43240');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('321', '77', 'North', 'Scranton', 'Pennsylvania', '18514');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('322', '28', 'Spaight', 'New Orleans', 'Louisiana', '70124');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('323', '75', 'Roxbury', 'Washington', 'District of Columbia', '56944');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('324', '70', 'Fulton', 'Orlando', 'Florida', '32885');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('325', '40', 'Cascade', 'El Paso', 'Texas', '88589');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('326', '82', 'Manufacturers', 'Cincinnati', 'Ohio', '45223');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('327', '94', 'Leroy', 'Punta Gorda', 'Florida', '33982');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('328', '42', 'Kenwood', 'Pittsburgh', 'Pennsylvania', '15266');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('329', '44', 'North', 'Boca Raton', 'Florida', '33499');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('330', '56', 'Alpine', 'Richmond', 'Virginia', '23260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('331', '98', 'Caliangt', 'Erie', 'Pennsylvania', '16534');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('332', '72', '8th', 'Washington', 'District of Columbia', '20299');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('333', '52', 'Thackeray', 'Durham', 'North Carolina', '27705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('334', '46', 'Schiller', 'Garden Grove', 'California', '92645');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('335', '68', 'Dunning', 'Norman', 'Oklahoma', '73071');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('336', '29', 'Alpine', 'Cincinnati', 'Ohio', '45264');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('337', '76', '7th', 'Punta Gorda', 'Florida', '33982');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('338', '59', 'Gale', 'Miami', 'Florida', '33261');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('339', '3', 'Bluestem', 'Virginia Beach', 'Virginia', '23464');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('340', '77', 'Tony', 'Mobile', 'Alabama', '36610');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('341', '63', 'Lawn', 'Naperville', 'Illinois', '60567');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('342', '80', 'Onsgard', 'New York City', 'New York', '10004');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('343', '63', 'Arkansas', 'Lubbock', 'Texas', '79452');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('344', '100', 'Farragut', 'Oklahoma City', 'Oklahoma', '73147');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('345', '26', 'Rutledge', 'Austin', 'Texas', '78726');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('346', '17', 'Katie', 'Van Nuys', 'California', '91499');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('347', '89', 'Rutledge', 'Rochester', 'New York', '14683');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('348', '5', 'Kipling', 'Corpus Christi', 'Texas', '78475');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('349', '65', 'Lake View', 'Oklahoma City', 'Oklahoma', '73190');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('350', '93', 'Esch', 'Boise', 'Idaho', '83727');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('351', '58', 'Browning', 'Los Angeles', 'California', '90065');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('352', '36', 'Ohio', 'Pensacola', 'Florida', '32575');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('353', '76', 'Kinsman', 'Dayton', 'Ohio', '45419');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('354', '34', 'Victoria', 'Charleston', 'West Virginia', '25321');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('355', '80', 'Morning', 'Reno', 'Nevada', '89510');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('356', '40', 'Jenna', 'Pittsburgh', 'Pennsylvania', '15215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('357', '75', 'Mallory', 'Lansing', 'Michigan', '48956');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('358', '76', 'Pine View', 'Portland', 'Oregon', '97240');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('359', '93', 'Barnett', 'Washington', 'District of Columbia', '20557');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('360', '95', 'Warrior', 'Dallas', 'Texas', '75205');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('361', '90', 'Clove', 'Saint Louis', 'Missouri', '63104');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('362', '50', 'Carberry', 'San Francisco', 'California', '94177');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('363', '54', 'Nelson', 'Denver', 'Colorado', '80241');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('364', '58', 'Corry', 'Dallas', 'Texas', '75226');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('365', '32', 'Carberry', 'Naples', 'Florida', '33963');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('366', '19', 'Hoffman', 'Sacramento', 'California', '95838');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('367', '68', 'Everett', 'Cleveland', 'Ohio', '44185');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('368', '68', '1st', 'New Orleans', 'Louisiana', '70187');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('369', '42', 'American', 'Dallas', 'Texas', '75287');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('370', '32', 'Anhalt', 'Dayton', 'Ohio', '45419');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('371', '54', 'Thompson', 'Honolulu', 'Hawaii', '96835');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('372', '16', 'Eagle Crest', 'Pasadena', 'Texas', '77505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('373', '39', 'Transport', 'Abilene', 'Texas', '79605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('374', '67', 'Mayfield', 'Harrisburg', 'Pennsylvania', '17140');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('375', '52', 'Jackson', 'Greenville', 'South Carolina', '29605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('376', '55', 'Monterey', 'Milwaukee', 'Wisconsin', '53234');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('377', '34', 'Truax', 'Tampa', 'Florida', '33686');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('378', '3', 'Surrey', 'Austin', 'Texas', '78789');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('379', '1', 'Melby', 'El Paso', 'Texas', '88574');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('380', '65', 'Parkside', 'Minneapolis', 'Minnesota', '55441');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('381', '14', 'Larry', 'White Plains', 'New York', '10633');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('382', '31', 'Lyons', 'Brockton', 'Massachusetts', '02305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('383', '86', 'Mayfield', 'Pensacola', 'Florida', '32595');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('384', '55', 'Dorton', 'Des Moines', 'Iowa', '50310');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('385', '77', 'Bobwhite', 'Hialeah', 'Florida', '33013');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('386', '44', 'Norway Maple', 'Lake Worth', 'Florida', '33462');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('387', '32', 'Goodland', 'Columbus', 'Ohio', '43226');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('388', '78', 'Northwestern', 'Las Vegas', 'Nevada', '89135');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('389', '4', 'Ronald Regan', 'Metairie', 'Louisiana', '70005');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('390', '13', 'Bluejay', 'Colorado Springs', 'Colorado', '80951');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('391', '59', 'Eggendart', 'Fresno', 'California', '93726');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('392', '88', 'Lyons', 'Scottsdale', 'Arizona', '85260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('393', '19', 'Grasskamp', 'Grand Rapids', 'Michigan', '49560');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('394', '2', 'Cascade', 'Dulles', 'Virginia', '20189');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('395', '66', 'Fulton', 'Toledo', 'Ohio', '43699');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('396', '79', 'Westerfield', 'Dallas', 'Texas', '75287');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('397', '26', 'Doe Crossing', 'Albuquerque', 'New Mexico', '87105');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('398', '27', 'Pleasure', 'Kansas City', 'Missouri', '64149');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('399', '73', 'Browning', 'Gainesville', 'Florida', '32610');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('400', '75', 'Mallory', 'Riverside', 'California', '92505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('401', '51', 'Hoffman', 'Houston', 'Texas', '77228');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('402', '12', 'Namekagon', 'Tacoma', 'Washington', '98464');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('403', '22', 'Spenser', 'Syracuse', 'New York', '13224');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('404', '38', 'Tennyson', 'Lake Worth', 'Florida', '33467');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('405', '36', 'Sutherland', 'Sacramento', 'California', '94273');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('406', '71', 'Longview', 'Waterbury', 'Connecticut', '06721');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('407', '8', 'Charing Cross', 'Muskegon', 'Michigan', '49444');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('408', '16', 'Fallview', 'Marietta', 'Georgia', '30066');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('409', '72', 'Warbler', 'Irvine', 'California', '92619');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('410', '58', 'Redwing', 'Jackson', 'Mississippi', '39236');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('411', '55', 'Roth', 'San Francisco', 'California', '94159');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('412', '51', 'Monica', 'Washington', 'District of Columbia', '20503');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('413', '27', 'Loomis', 'Virginia Beach', 'Virginia', '23454');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('414', '17', 'Heffernan', 'Albany', 'Georgia', '31704');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('415', '79', 'Heath', 'Kansas City', 'Missouri', '64130');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('416', '2', 'Pepper Wood', 'Lexington', 'Kentucky', '40591');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('417', '89', 'Schiller', 'San Diego', 'California', '92153');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('418', '58', 'Miller', 'Paterson', 'New Jersey', '07505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('419', '89', 'American', 'Charleston', 'West Virginia', '25356');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('420', '40', 'Hermina', 'Jamaica', 'New York', '11431');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('421', '85', 'Delladonna', 'Honolulu', 'Hawaii', '96850');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('422', '97', 'Spaight', 'South Bend', 'Indiana', '46614');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('423', '60', 'Carpenter', 'Brooklyn', 'New York', '11247');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('424', '51', 'Mayfield', 'Oklahoma City', 'Oklahoma', '73109');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('425', '17', 'Manufacturers', 'Lansing', 'Michigan', '48912');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('426', '97', 'Mcbride', 'Des Moines', 'Iowa', '50320');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('427', '91', 'Elmside', 'Clearwater', 'Florida', '34620');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('428', '89', 'Dottie', 'New York City', 'New York', '10175');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('429', '18', 'Annamark', 'Oklahoma City', 'Oklahoma', '73147');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('430', '34', 'Derek', 'Arvada', 'Colorado', '80005');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('431', '51', 'Scott', 'Houston', 'Texas', '77293');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('432', '75', 'Caliangt', 'Topeka', 'Kansas', '66642');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('433', '85', 'Messerschmidt', 'El Paso', 'Texas', '79911');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('434', '50', 'Duke', 'Richmond', 'Virginia', '23242');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('435', '23', 'Loftsgordon', 'Sacramento', 'California', '94250');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('436', '88', 'Bunker Hill', 'Sacramento', 'California', '94273');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('437', '20', 'Bunting', 'Young America', 'Minnesota', '55557');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('438', '81', 'Lindbergh', 'Louisville', 'Kentucky', '40256');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('439', '47', 'Stang', 'Tulsa', 'Oklahoma', '74149');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('440', '34', 'Grasskamp', 'Las Vegas', 'Nevada', '89160');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('441', '16', 'Memorial', 'Columbus', 'Georgia', '31914');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('442', '36', 'Cordelia', 'Raleigh', 'North Carolina', '27690');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('443', '39', 'Crest Line', 'Saint Petersburg', 'Florida', '33705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('444', '23', 'Memorial', 'Orlando', 'Florida', '32803');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('445', '18', 'Glendale', 'Montgomery', 'Alabama', '36134');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('446', '30', 'Veith', 'Burbank', 'California', '91505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('447', '10', 'Portage', 'Charlottesville', 'Virginia', '22903');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('448', '20', 'Northwestern', 'Miami', 'Florida', '33134');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('449', '91', 'Fairfield', 'Stockton', 'California', '95219');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('450', '24', 'Fairview', 'Richmond', 'Virginia', '23260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('451', '48', 'Granby', 'Oakland', 'California', '94611');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('452', '9', 'Ruskin', 'Washington', 'District of Columbia', '20226');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('453', '48', 'Maple Wood', 'Shawnee Mission', 'Kansas', '66215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('454', '94', 'Lawn', 'Burbank', 'California', '91505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('455', '97', 'Lerdahl', 'Louisville', 'Kentucky', '40293');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('456', '16', 'Banding', 'Greeley', 'Colorado', '80638');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('457', '64', 'Cardinal', 'Danbury', 'Connecticut', '06816');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('458', '16', 'Clarendon', 'Indianapolis', 'Indiana', '46278');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('459', '10', 'Springs', 'Huntington', 'West Virginia', '25770');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('460', '79', 'Erie', 'Jamaica', 'New York', '11431');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('461', '35', 'Rusk', 'Springfield', 'Illinois', '62756');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('462', '49', 'Clove', 'New York City', 'New York', '10099');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('463', '33', 'Lakewood Gardens', 'Springfield', 'Illinois', '62711');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('464', '22', 'Becker', 'Jacksonville', 'Florida', '32230');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('465', '57', 'Emmet', 'Kansas City', 'Missouri', '64190');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('466', '84', 'Hovde', 'Fort Smith', 'Arkansas', '72916');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('467', '28', 'Ridge Oak', 'Sacramento', 'California', '95828');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('468', '43', 'Atwood', 'Dayton', 'Ohio', '45426');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('469', '58', 'Arizona', 'New York City', 'New York', '10004');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('470', '32', 'Cascade', 'Phoenix', 'Arizona', '85015');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('471', '77', 'Bultman', 'Evansville', 'Indiana', '47705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('472', '31', 'Barby', 'Washington', 'District of Columbia', '20409');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('473', '43', 'Lyons', 'Peoria', 'Illinois', '61635');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('474', '75', 'Namekagon', 'Petaluma', 'California', '94975');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('475', '80', 'American Ash', 'Austin', 'Texas', '78721');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('476', '94', 'Schiller', 'Lafayette', 'Louisiana', '70505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('477', '35', 'David', 'Gary', 'Indiana', '46406');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('478', '60', 'Barby', 'Fort Smith', 'Arkansas', '72905');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('479', '19', 'Scofield', 'Fort Worth', 'Texas', '76129');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('480', '66', 'Muir', 'Falls Church', 'Virginia', '22047');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('481', '45', 'International', 'Anchorage', 'Alaska', '99517');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('482', '60', 'Transport', 'Milwaukee', 'Wisconsin', '53263');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('483', '60', 'Oakridge', 'Washington', 'District of Columbia', '20016');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('484', '67', 'Muir', 'Columbus', 'Georgia', '31998');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('485', '77', 'Artisan', 'Houston', 'Texas', '77085');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('486', '37', 'Ridgeway', 'Tacoma', 'Washington', '98447');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('487', '43', 'Columbus', 'New York City', 'New York', '10203');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('488', '60', 'Kinsman', 'Anchorage', 'Alaska', '99512');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('489', '46', 'Melby', 'Raleigh', 'North Carolina', '27615');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('490', '45', 'Prentice', 'Stockton', 'California', '95298');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('491', '93', 'Cherokee', 'San Jose', 'California', '95155');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('492', '63', 'Miller', 'Odessa', 'Texas', '79769');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('493', '73', 'Maywood', 'Houston', 'Texas', '77035');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('494', '48', 'Dexter', 'Springfield', 'Massachusetts', '01105');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('495', '23', 'Scott', 'Kingsport', 'Tennessee', '37665');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('496', '22', 'Fremont', 'Newport News', 'Virginia', '23612');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('497', '2', 'Luster', 'Orlando', 'Florida', '32885');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('498', '95', 'Sauthoff', 'Maple Plain', 'Minnesota', '55572');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('499', '71', 'Calypso', 'Waltham', 'Massachusetts', '02453');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('500', '11', 'Kensington', 'Charlotte', 'North Carolina', '28263');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('501', '89', 'Menomonie', 'Austin', 'Texas', '78754');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('502', '22', 'Northland', 'Rockford', 'Illinois', '61105');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('503', '13', 'Dapin', 'Grand Forks', 'North Dakota', '58207');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('504', '78', 'Morning', 'Myrtle Beach', 'South Carolina', '29579');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('505', '13', 'Wayridge', 'Bakersfield', 'California', '93386');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('506', '59', 'Dryden', 'Atlanta', 'Georgia', '30351');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('507', '56', 'Dennis', 'Hartford', 'Connecticut', '06140');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('508', '3', 'Dovetail', 'Tampa', 'Florida', '33694');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('509', '51', 'Loeprich', 'Long Beach', 'California', '90831');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('510', '72', 'Kim', 'Springfield', 'Ohio', '45505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('511', '99', 'Moland', 'Grand Rapids', 'Michigan', '49560');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('512', '84', 'Nevada', 'Troy', 'Michigan', '48098');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('513', '82', 'Pearson', 'Tulsa', 'Oklahoma', '74184');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('514', '32', '2nd', 'Salt Lake City', 'Utah', '84170');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('515', '48', 'Mayer', 'Suffolk', 'Virginia', '23436');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('516', '37', 'Meadow Valley', 'Oklahoma City', 'Oklahoma', '73190');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('517', '91', 'Clarendon', 'Las Vegas', 'Nevada', '89135');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('518', '60', 'Di Loreto', 'Kansas City', 'Missouri', '64149');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('519', '50', 'Basil', 'Ashburn', 'Virginia', '22093');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('520', '12', 'Claremont', 'Fort Worth', 'Texas', '76192');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('521', '52', 'Delaware', 'Washington', 'District of Columbia', '20520');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('522', '46', 'Di Loreto', 'San Antonio', 'Texas', '78240');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('523', '80', 'Crescent Oaks', 'Myrtle Beach', 'South Carolina', '29579');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('524', '37', 'Northridge', 'Colorado Springs', 'Colorado', '80945');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('525', '57', 'Arrowood', 'Los Angeles', 'California', '90040');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('526', '77', 'Thierer', 'Little Rock', 'Arkansas', '72231');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('527', '11', 'Little Fleur', 'Olympia', 'Washington', '98516');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('528', '1', 'Sutherland', 'Philadelphia', 'Pennsylvania', '19151');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('529', '1', 'Paget', 'Albany', 'New York', '12255');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('530', '81', 'Kenwood', 'Inglewood', 'California', '90305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('531', '20', 'Jenna', 'Saint Louis', 'Missouri', '63167');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('532', '1', 'Arapahoe', 'Wilmington', 'North Carolina', '28405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('533', '100', 'Saint Paul', 'Littleton', 'Colorado', '80126');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('534', '3', 'Starling', 'Alexandria', 'Virginia', '22313');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('535', '89', 'Leroy', 'Nashville', 'Tennessee', '37210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('536', '32', 'Sutherland', 'New York City', 'New York', '10170');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('537', '4', 'Pennsylvania', 'Lees Summit', 'Missouri', '64082');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('538', '9', 'Alpine', 'Atlanta', 'Georgia', '30316');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('539', '40', 'Loftsgordon', 'Orlando', 'Florida', '32825');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('540', '9', 'Superior', 'Birmingham', 'Alabama', '35254');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('541', '28', 'Morrow', 'Fresno', 'California', '93762');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('542', '12', 'Garrison', 'Daytona Beach', 'Florida', '32128');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('543', '33', 'Golf', 'Phoenix', 'Arizona', '85099');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('544', '56', 'Bayside', 'Dallas', 'Texas', '75387');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('545', '51', 'Rockefeller', 'Jacksonville', 'Florida', '32259');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('546', '2', 'Lien', 'Rochester', 'New York', '14619');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('547', '33', 'Ridge Oak', 'Boston', 'Massachusetts', '02114');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('548', '10', 'Jana', 'Newton', 'Massachusetts', '02162');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('549', '6', 'Alpine', 'San Diego', 'California', '92191');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('550', '95', 'Golf', 'Pittsburgh', 'Pennsylvania', '15210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('551', '20', 'David', 'Des Moines', 'Iowa', '50305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('552', '26', 'Melby', 'Houston', 'Texas', '77218');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('553', '39', 'Warner', 'Houston', 'Texas', '77015');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('554', '5', 'Sherman', 'Abilene', 'Texas', '79605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('555', '9', 'Lake View', 'Louisville', 'Kentucky', '40205');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('556', '13', 'Starling', 'Jacksonville', 'Florida', '32204');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('557', '75', 'Carpenter', 'Arvada', 'Colorado', '80005');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('558', '71', 'Norway Maple', 'Bronx', 'New York', '10464');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('559', '17', 'Vera', 'Phoenix', 'Arizona', '85072');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('560', '99', 'Transport', 'West Palm Beach', 'Florida', '33411');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('561', '98', 'Trailsway', 'Spartanburg', 'South Carolina', '29305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('562', '90', 'Delladonna', 'San Jose', 'California', '95133');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('563', '19', 'Michigan', 'Houston', 'Texas', '77288');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('564', '88', 'Arizona', 'Lake Charles', 'Louisiana', '70616');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('565', '92', 'Loftsgordon', 'Sacramento', 'California', '95838');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('566', '22', 'Memorial', 'El Paso', 'Texas', '79999');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('567', '16', 'South', 'Fort Myers', 'Florida', '33913');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('568', '77', 'Summerview', 'Johnson City', 'Tennessee', '37605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('569', '93', 'Raven', 'Knoxville', 'Tennessee', '37914');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('570', '21', 'Schurz', 'Hattiesburg', 'Mississippi', '39404');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('571', '50', 'Porter', 'Bryan', 'Texas', '77806');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('572', '94', 'American Ash', 'Indianapolis', 'Indiana', '46231');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('573', '63', 'Division', 'Tuscaloosa', 'Alabama', '35405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('574', '50', 'Hooker', 'Pensacola', 'Florida', '32575');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('575', '69', 'Monterey', 'Pompano Beach', 'Florida', '33064');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('576', '49', 'Corscot', 'San Jose', 'California', '95150');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('577', '33', 'Pine View', 'Syracuse', 'New York', '13217');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('578', '98', 'Dunning', 'Los Angeles', 'California', '90040');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('579', '87', 'Browning', 'Amarillo', 'Texas', '79159');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('580', '55', 'Stuart', 'Akron', 'Ohio', '44321');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('581', '64', 'Fordem', 'Greensboro', 'North Carolina', '27499');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('582', '72', 'Maryland', 'Minneapolis', 'Minnesota', '55480');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('583', '8', 'Ludington', 'San Francisco', 'California', '94169');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('584', '53', 'Ludington', 'Santa Rosa', 'California', '95405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('585', '74', 'Gina', 'El Paso', 'Texas', '79928');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('586', '55', 'Arizona', 'Portland', 'Oregon', '97286');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('587', '75', 'Bashford', 'Lansing', 'Michigan', '48912');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('588', '73', 'Warner', 'El Paso', 'Texas', '88589');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('589', '27', 'Brentwood', 'Independence', 'Missouri', '64054');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('590', '25', 'Brentwood', 'New Orleans', 'Louisiana', '70154');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('591', '66', 'Caliangt', 'Evansville', 'Indiana', '47705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('592', '29', 'Thompson', 'Washington', 'District of Columbia', '20220');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('593', '56', 'Wayridge', 'Duluth', 'Georgia', '30195');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('594', '54', 'Arkansas', 'Aurora', 'Colorado', '80015');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('595', '25', 'Hanover', 'Boston', 'Massachusetts', '02119');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('596', '88', 'Kings', 'Amarillo', 'Texas', '79165');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('597', '63', 'Linden', 'Washington', 'District of Columbia', '20557');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('598', '78', 'Kenwood', 'Anchorage', 'Alaska', '99512');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('599', '52', 'Lillian', 'Miami', 'Florida', '33142');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('600', '51', 'Springs', 'Tyler', 'Texas', '75705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('601', '65', 'Dexter', 'Omaha', 'Nebraska', '68144');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('602', '71', 'American', 'Salt Lake City', 'Utah', '84120');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('603', '51', 'Hagan', 'Minneapolis', 'Minnesota', '55470');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('604', '48', 'Buena Vista', 'Washington', 'District of Columbia', '20029');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('605', '12', 'Chive', 'Newark', 'Delaware', '19725');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('606', '99', 'Paget', 'Pompano Beach', 'Florida', '33064');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('607', '3', 'Oxford', 'Carol Stream', 'Illinois', '60351');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('608', '16', 'Browning', 'San Diego', 'California', '92115');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('609', '50', 'Anthes', 'Green Bay', 'Wisconsin', '54305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('610', '90', 'Southridge', 'Washington', 'District of Columbia', '20414');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('611', '70', 'Dixon', 'Nashville', 'Tennessee', '37245');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('612', '18', 'Burrows', 'Oklahoma City', 'Oklahoma', '73142');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('613', '34', 'Dryden', 'New Orleans', 'Louisiana', '70174');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('614', '29', 'Scoville', 'Pittsburgh', 'Pennsylvania', '15210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('615', '17', 'Scofield', 'Spring', 'Texas', '77386');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('616', '21', 'Russell', 'Melbourne', 'Florida', '32941');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('617', '85', 'Ruskin', 'Shawnee Mission', 'Kansas', '66286');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('618', '47', 'Mayfield', 'Austin', 'Texas', '78726');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('619', '52', 'Sheridan', 'Monticello', 'Minnesota', '55565');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('620', '67', 'Miller', 'Tulsa', 'Oklahoma', '74184');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('621', '80', 'Westerfield', 'San Francisco', 'California', '94142');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('622', '12', 'Larry', 'Fort Lauderdale', 'Florida', '33355');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('623', '33', 'Reinke', 'Seattle', 'Washington', '98185');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('624', '27', 'Anthes', 'Birmingham', 'Alabama', '35290');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('625', '77', 'Bobwhite', 'Washington', 'District of Columbia', '20260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('626', '52', 'Dryden', 'Berkeley', 'California', '94712');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('627', '77', 'Surrey', 'Scranton', 'Pennsylvania', '18514');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('628', '72', 'Lindbergh', 'Jackson', 'Mississippi', '39204');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('629', '38', 'Melody', 'Denver', 'Colorado', '80228');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('630', '80', '7th', 'Houston', 'Texas', '77266');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('631', '9', 'Summerview', 'Florence', 'South Carolina', '29505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('632', '51', 'Westport', 'Saint Louis', 'Missouri', '63169');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('633', '23', 'Ilene', 'San Bernardino', 'California', '92424');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('634', '3', 'Mcbride', 'Amarillo', 'Texas', '79188');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('635', '71', 'Washington', 'Columbus', 'Mississippi', '39705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('636', '45', 'Shasta', 'Baltimore', 'Maryland', '21216');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('637', '27', 'Johnson', 'Duluth', 'Georgia', '30096');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('638', '38', 'Ridge Oak', 'Des Moines', 'Iowa', '50315');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('639', '21', 'Westport', 'New York City', 'New York', '10009');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('640', '41', 'Judy', 'Birmingham', 'Alabama', '35295');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('641', '4', 'Marquette', 'Valdosta', 'Georgia', '31605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('642', '73', 'Boyd', 'Kansas City', 'Missouri', '64199');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('643', '20', 'Dixon', 'San Antonio', 'Texas', '78210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('644', '15', 'Eastlawn', 'Sioux City', 'Iowa', '51105');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('645', '42', 'Algoma', 'Amarillo', 'Texas', '79171');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('646', '34', 'Amoth', 'Anaheim', 'California', '92825');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('647', '42', 'Eastwood', 'Cincinnati', 'Ohio', '45228');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('648', '75', 'American Ash', 'Pittsburgh', 'Pennsylvania', '15210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('649', '76', 'Service', 'Charlotte', 'North Carolina', '28263');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('650', '43', 'Northfield', 'Dayton', 'Ohio', '45403');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('651', '57', 'Mitchell', 'Atlanta', 'Georgia', '30380');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('652', '2', 'Vidon', 'El Paso', 'Texas', '88584');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('653', '81', 'Jenna', 'Virginia Beach', 'Virginia', '23454');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('654', '73', 'Toban', 'San Diego', 'California', '92186');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('655', '46', 'Del Sol', 'Bonita Springs', 'Florida', '34135');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('656', '96', 'Heffernan', 'Brooklyn', 'New York', '11215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('657', '29', 'West', 'Washington', 'District of Columbia', '20210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('658', '87', 'Forster', 'Washington', 'District of Columbia', '20575');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('659', '35', 'Corscot', 'Cincinnati', 'Ohio', '45243');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('660', '40', 'American', 'Lincoln', 'Nebraska', '68517');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('661', '2', 'Spenser', 'Saginaw', 'Michigan', '48604');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('662', '1', 'Trailsway', 'Huntsville', 'Alabama', '35805');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('663', '38', 'Sloan', 'El Paso', 'Texas', '79984');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('664', '12', 'Westridge', 'Indianapolis', 'Indiana', '46226');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('665', '16', 'Barby', 'Schenectady', 'New York', '12325');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('666', '46', 'Melvin', 'Lake Charles', 'Louisiana', '70607');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('667', '79', 'Hoard', 'Oklahoma City', 'Oklahoma', '73114');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('668', '55', 'Fremont', 'Macon', 'Georgia', '31217');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('669', '83', 'Redwing', 'Austin', 'Texas', '78754');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('670', '38', 'Helena', 'Los Angeles', 'California', '90055');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('671', '87', 'Cherokee', 'Oklahoma City', 'Oklahoma', '73114');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('672', '45', 'Derek', 'Fort Wayne', 'Indiana', '46862');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('673', '62', 'Melody', 'Los Angeles', 'California', '90005');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('674', '65', 'Northport', 'Fort Smith', 'Arkansas', '72916');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('675', '79', 'Evergreen', 'San Antonio', 'Texas', '78220');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('676', '65', 'Meadow Vale', 'Spokane', 'Washington', '99210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('677', '36', 'Melrose', 'Jefferson City', 'Missouri', '65110');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('678', '27', 'Johnson', 'Torrance', 'California', '90505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('679', '75', 'Pine View', 'Jamaica', 'New York', '11447');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('680', '91', 'Clove', 'Tyler', 'Texas', '75705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('681', '62', 'Farmco', 'Colorado Springs', 'Colorado', '80905');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('682', '1', 'Tony', 'Albany', 'New York', '12222');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('683', '17', 'Pawling', 'Indianapolis', 'Indiana', '46278');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('684', '64', 'Cambridge', 'Stamford', 'Connecticut', '06922');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('685', '29', 'Express', 'Bradenton', 'Florida', '34282');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('686', '51', 'Delaware', 'Scottsdale', 'Arizona', '85271');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('687', '8', 'Aberg', 'Charlotte', 'North Carolina', '28278');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('688', '6', 'Rieder', 'Palmdale', 'California', '93591');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('689', '84', 'Main', 'Minneapolis', 'Minnesota', '55407');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('690', '68', 'Service', 'Hartford', 'Connecticut', '06160');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('691', '76', 'Maryland', 'Knoxville', 'Tennessee', '37931');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('692', '27', 'Golf', 'Richmond', 'Virginia', '23225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('693', '66', 'Russell', 'Baltimore', 'Maryland', '21211');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('694', '50', 'Meadow Vale', 'Raleigh', 'North Carolina', '27615');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('695', '3', 'Thackeray', 'Austin', 'Texas', '78783');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('696', '46', 'Village', 'Marietta', 'Georgia', '30066');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('697', '87', 'Holy Cross', 'Washington', 'District of Columbia', '20029');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('698', '93', 'Dapin', 'Albany', 'New York', '12247');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('699', '76', 'Clemons', 'Topeka', 'Kansas', '66617');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('700', '58', 'Moose', 'Young America', 'Minnesota', '55564');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('701', '56', 'Sundown', 'College Station', 'Texas', '77844');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('702', '22', 'Acker', 'Saint Louis', 'Missouri', '63150');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('703', '46', 'Gina', 'San Antonio', 'Texas', '78210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('704', '50', 'Arizona', 'Dallas', 'Texas', '75379');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('705', '89', 'Kennedy', 'North Las Vegas', 'Nevada', '89087');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('706', '45', 'Merrick', 'Salt Lake City', 'Utah', '84110');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('707', '36', 'Dakota', 'Stockton', 'California', '95298');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('708', '59', 'Waubesa', 'Salt Lake City', 'Utah', '84170');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('709', '69', 'Mayer', 'New York City', 'New York', '10110');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('710', '23', 'Browning', 'Jackson', 'Mississippi', '39282');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('711', '90', 'Eagan', 'Toledo', 'Ohio', '43615');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('712', '65', 'Meadow Vale', 'Abilene', 'Texas', '79605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('713', '46', 'Homewood', 'Omaha', 'Nebraska', '68197');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('714', '87', 'Northview', 'Indianapolis', 'Indiana', '46239');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('715', '38', 'Scofield', 'Denver', 'Colorado', '80235');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('716', '83', 'Browning', 'Trenton', 'New Jersey', '08638');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('717', '26', 'Blackbird', 'Milwaukee', 'Wisconsin', '53225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('718', '68', 'Lakewood', 'Reston', 'Virginia', '20195');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('719', '39', 'Village', 'San Jose', 'California', '95155');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('720', '26', 'Quincy', 'Oklahoma City', 'Oklahoma', '73173');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('721', '3', 'Annamark', 'Schaumburg', 'Illinois', '60193');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('722', '66', 'Lakewood', 'Monticello', 'Minnesota', '55565');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('723', '71', 'Kim', 'Birmingham', 'Alabama', '35285');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('724', '49', 'Caliangt', 'Albany', 'Georgia', '31704');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('725', '79', 'Utah', 'Tallahassee', 'Florida', '32314');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('726', '46', 'Gateway', 'Roanoke', 'Virginia', '24048');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('727', '100', 'Carey', 'Kansas City', 'Missouri', '64179');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('728', '3', 'Roxbury', 'Chicago', 'Illinois', '60604');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('729', '48', 'John Wall', 'Tampa', 'Florida', '33633');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('730', '76', '5th', 'Albany', 'Georgia', '31704');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('731', '79', 'Northfield', 'Memphis', 'Tennessee', '38119');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('732', '37', 'Spohn', 'Denver', 'Colorado', '80255');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('733', '58', 'Morrow', 'Terre Haute', 'Indiana', '47805');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('734', '20', 'Sutherland', 'San Bernardino', 'California', '92405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('735', '100', 'Delladonna', 'Huntington', 'West Virginia', '25711');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('736', '37', 'Graceland', 'Charlotte', 'North Carolina', '28220');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('737', '36', 'Sycamore', 'Los Angeles', 'California', '90025');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('738', '8', 'Talisman', 'Spokane', 'Washington', '99260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('739', '32', 'South', 'Hagerstown', 'Maryland', '21747');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('740', '45', 'Northfield', 'Los Angeles', 'California', '90189');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('741', '17', 'Crescent Oaks', 'San Antonio', 'Texas', '78296');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('742', '100', 'Vidon', 'Columbus', 'Ohio', '43210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('743', '3', 'Calypso', 'Louisville', 'Kentucky', '40287');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('744', '57', 'Independence', 'Trenton', 'New Jersey', '08695');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('745', '58', 'Pine View', 'Saint Louis', 'Missouri', '63104');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('746', '25', 'Myrtle', 'Fargo', 'North Dakota', '58122');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('747', '20', 'Rutledge', 'Corpus Christi', 'Texas', '78405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('748', '50', 'Waubesa', 'Atlanta', 'Georgia', '30358');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('749', '20', 'Carberry', 'Cincinnati', 'Ohio', '45271');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('750', '22', 'Center', 'Humble', 'Texas', '77346');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('751', '17', 'Kennedy', 'Riverside', 'California', '92505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('752', '43', 'Namekagon', 'Beaverton', 'Oregon', '97075');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('753', '50', 'Petterle', 'Richmond', 'Virginia', '23242');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('754', '51', 'Hooker', 'Louisville', 'Kentucky', '40225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('755', '7', 'Atwood', 'Newark', 'Delaware', '19725');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('756', '87', 'Artisan', 'Mc Keesport', 'Pennsylvania', '15134');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('757', '85', 'Jana', 'Springfield', 'Missouri', '65810');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('758', '28', 'Grover', 'Fort Worth', 'Texas', '76134');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('759', '21', 'Redwing', 'Anchorage', 'Alaska', '99507');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('760', '49', '7th', 'Hot Springs National Park', 'Arkansas', '71914');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('761', '79', 'Pearson', 'Fort Wayne', 'Indiana', '46896');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('762', '17', 'Southridge', 'Prescott', 'Arizona', '86305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('763', '51', 'Haas', 'Terre Haute', 'Indiana', '47812');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('764', '49', 'Scoville', 'Albuquerque', 'New Mexico', '87180');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('765', '88', 'Pine View', 'Brooklyn', 'New York', '11236');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('766', '52', 'Eagan', 'Peoria', 'Illinois', '61635');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('767', '81', 'Waubesa', 'Maple Plain', 'Minnesota', '55572');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('768', '13', 'Sugar', 'Lake Charles', 'Louisiana', '70607');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('769', '12', 'Hoepker', 'Des Moines', 'Iowa', '50362');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('770', '50', 'Jana', 'Charlotte', 'North Carolina', '28263');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('771', '93', 'Melrose', 'Seattle', 'Washington', '98115');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('772', '17', 'Emmet', 'Van Nuys', 'California', '91411');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('773', '11', 'Oak Valley', 'Orlando', 'Florida', '32859');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('774', '12', 'Pankratz', 'Los Angeles', 'California', '90010');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('775', '32', 'North', 'Staten Island', 'New York', '10305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('776', '59', 'Columbus', 'Phoenix', 'Arizona', '85040');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('777', '3', 'Forest Run', 'Jackson', 'Mississippi', '39236');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('778', '67', 'Vidon', 'Charleston', 'West Virginia', '25313');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('779', '84', 'American Ash', 'Paterson', 'New Jersey', '07505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('780', '45', 'Brown', 'Englewood', 'Colorado', '80150');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('781', '34', 'Hooker', 'Washington', 'District of Columbia', '20337');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('782', '5', 'Mockingbird', 'Norfolk', 'Virginia', '23509');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('783', '49', 'Thierer', 'Louisville', 'Kentucky', '40220');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('784', '69', 'Norway Maple', 'Atlanta', 'Georgia', '31196');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('785', '74', 'Vernon', 'El Paso', 'Texas', '88541');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('786', '49', 'Anniversary', 'Peoria', 'Illinois', '61635');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('787', '9', 'Fairfield', 'Jacksonville', 'Florida', '32225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('788', '55', 'Fordem', 'Anaheim', 'California', '92805');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('789', '5', 'Coolidge', 'College Station', 'Texas', '77844');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('790', '86', 'Clyde Gallagher', 'Savannah', 'Georgia', '31416');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('791', '93', 'Sullivan', 'Lexington', 'Kentucky', '40546');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('792', '15', 'Quincy', 'Evansville', 'Indiana', '47737');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('793', '79', 'Knutson', 'Boston', 'Massachusetts', '02104');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('794', '24', 'Arkansas', 'Erie', 'Pennsylvania', '16522');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('795', '84', 'Mendota', 'Portsmouth', 'New Hampshire', '00214');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('796', '81', 'Prairieview', 'Cincinnati', 'Ohio', '45223');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('797', '83', 'Lerdahl', 'El Paso', 'Texas', '88574');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('798', '73', 'Troy', 'Chicago', 'Illinois', '60619');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('799', '81', 'Mallard', 'Nashville', 'Tennessee', '37228');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('800', '59', 'Sunfield', 'Largo', 'Florida', '34643');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('801', '1', 'Darwin', 'Huntsville', 'Alabama', '35815');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('802', '33', 'Swallow', 'Fayetteville', 'North Carolina', '28305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('803', '13', 'Dovetail', 'Wichita', 'Kansas', '67215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('804', '5', 'Glacier Hill', 'Buffalo', 'New York', '14210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('805', '3', 'Portage', 'Milwaukee', 'Wisconsin', '53263');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('806', '81', '5th', 'San Jose', 'California', '95128');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('807', '76', 'North', 'Baltimore', 'Maryland', '21290');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('808', '67', 'Spaight', 'Atlanta', 'Georgia', '30340');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('809', '36', 'Esker', 'Charleston', 'West Virginia', '25389');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('810', '75', 'Pine View', 'Memphis', 'Tennessee', '38104');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('811', '29', 'Mayer', 'El Paso', 'Texas', '88574');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('812', '20', 'Northfield', 'Dallas', 'Texas', '75260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('813', '70', 'Mayfield', 'Trenton', 'New Jersey', '08603');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('814', '53', 'Portage', 'Washington', 'District of Columbia', '20420');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('815', '65', 'Hanson', 'San Diego', 'California', '92165');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('816', '89', 'Green', 'Colorado Springs', 'Colorado', '80995');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('817', '75', 'Marquette', 'Huntsville', 'Texas', '77343');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('818', '50', 'Schlimgen', 'Orlando', 'Florida', '32859');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('819', '50', 'Dorton', 'Lafayette', 'Louisiana', '70593');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('820', '52', 'Ludington', 'Chicago', 'Illinois', '60646');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('821', '31', 'Pearson', 'Longview', 'Texas', '75605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('822', '87', 'Helena', 'Seattle', 'Washington', '98158');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('823', '14', 'Burning Wood', 'Stamford', 'Connecticut', '06912');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('824', '11', 'Harper', 'Salinas', 'California', '93907');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('825', '52', 'Rockefeller', 'Des Moines', 'Iowa', '50369');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('826', '18', 'Mockingbird', 'Fort Lauderdale', 'Florida', '33325');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('827', '44', 'Michigan', 'Worcester', 'Massachusetts', '01610');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('828', '33', 'Hazelcrest', 'Greensboro', 'North Carolina', '27409');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('829', '34', 'Mifflin', 'Sacramento', 'California', '95838');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('830', '40', 'Thierer', 'Tempe', 'Arizona', '85284');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('831', '91', '3rd', 'Odessa', 'Texas', '79764');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('832', '14', 'Packers', 'Arlington', 'Virginia', '22212');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('833', '65', 'Stone Corner', 'Amarillo', 'Texas', '79182');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('834', '65', 'Harbort', 'Fargo', 'North Dakota', '58106');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('835', '66', 'Hovde', 'Pittsburgh', 'Pennsylvania', '15205');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('836', '7', 'Milwaukee', 'Pensacola', 'Florida', '32505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('837', '74', 'Mosinee', 'Honolulu', 'Hawaii', '96820');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('838', '61', 'Crownhardt', 'Schenectady', 'New York', '12325');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('839', '70', 'North', 'Lubbock', 'Texas', '79405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('840', '22', 'Carpenter', 'Durham', 'North Carolina', '27705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('841', '48', 'Bowman', 'Saint Paul', 'Minnesota', '55114');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('842', '26', 'Mosinee', 'Missoula', 'Montana', '59806');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('843', '15', 'Graceland', 'Dallas', 'Texas', '75353');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('844', '69', 'Karstens', 'Washington', 'District of Columbia', '20067');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('845', '19', 'Oakridge', 'Jackson', 'Mississippi', '39236');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('846', '78', 'Sachtjen', 'Wilmington', 'Delaware', '19892');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('847', '90', 'Hooker', 'Columbia', 'South Carolina', '29225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('848', '94', 'Bartelt', 'Peoria', 'Arizona', '85383');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('849', '26', 'Cherokee', 'Scranton', 'Pennsylvania', '18505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('850', '79', 'Sugar', 'Cleveland', 'Ohio', '44130');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('851', '39', 'Hollow Ridge', 'Bryan', 'Texas', '77806');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('852', '70', 'School', 'Norcross', 'Georgia', '30092');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('853', '93', 'Steensland', 'Baltimore', 'Maryland', '21265');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('854', '33', 'Rutledge', 'Manchester', 'New Hampshire', '03105');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('855', '45', 'Holy Cross', 'Mansfield', 'Ohio', '44905');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('856', '79', 'Manufacturers', 'Salt Lake City', 'Utah', '84152');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('857', '78', 'Pierstorff', 'Portland', 'Oregon', '97255');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('858', '74', 'Kennedy', 'Austin', 'Texas', '78726');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('859', '34', 'Holy Cross', 'San Antonio', 'Texas', '78296');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('860', '42', 'Bartelt', 'Panama City', 'Florida', '32405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('861', '96', 'Oxford', 'Jamaica', 'New York', '11436');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('862', '89', 'Southridge', 'San Jose', 'California', '95118');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('863', '7', 'Bunting', 'Philadelphia', 'Pennsylvania', '19093');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('864', '30', 'Thierer', 'Lansing', 'Michigan', '48901');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('865', '98', 'Sage', 'Lincoln', 'Nebraska', '68517');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('866', '25', 'Mesta', 'Raleigh', 'North Carolina', '27635');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('867', '78', 'Buena Vista', 'Charleston', 'West Virginia', '25321');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('868', '4', 'Gateway', 'Columbus', 'Georgia', '31998');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('869', '88', 'Main', 'Birmingham', 'Alabama', '35279');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('870', '28', 'Blaine', 'New York City', 'New York', '10034');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('871', '48', 'Calypso', 'Savannah', 'Georgia', '31410');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('872', '10', 'Randy', 'Maple Plain', 'Minnesota', '55572');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('873', '14', 'Westend', 'Chandler', 'Arizona', '85246');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('874', '82', 'Oneill', 'Vienna', 'Virginia', '22184');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('875', '5', 'Goodland', 'Santa Fe', 'New Mexico', '87505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('876', '68', 'Golf Course', 'Birmingham', 'Alabama', '35205');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('877', '61', 'Merrick', 'El Paso', 'Texas', '88563');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('878', '85', 'Stoughton', 'Kansas City', 'Missouri', '64142');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('879', '23', 'Maple', 'Palo Alto', 'California', '94302');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('880', '56', 'Fuller', 'El Paso', 'Texas', '79911');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('881', '60', 'Riverside', 'Kansas City', 'Missouri', '64125');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('882', '55', 'Hayes', 'Plano', 'Texas', '75074');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('883', '98', 'Evergreen', 'Utica', 'New York', '13505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('884', '74', 'Nobel', 'Fort Wayne', 'Indiana', '46805');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('885', '2', 'Hooker', 'Lexington', 'Kentucky', '40596');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('886', '82', 'Carpenter', 'Madison', 'Wisconsin', '53726');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('887', '49', 'Nelson', 'Jackson', 'Mississippi', '39282');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('888', '90', 'Norway Maple', 'Cedar Rapids', 'Iowa', '52410');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('889', '33', 'Garrison', 'Carol Stream', 'Illinois', '60351');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('890', '100', 'East', 'Alexandria', 'Virginia', '22313');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('891', '55', 'Sheridan', 'Tucson', 'Arizona', '85715');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('892', '84', 'Sugar', 'Birmingham', 'Alabama', '35279');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('893', '99', 'American', 'North Hollywood', 'California', '91616');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('894', '8', 'Hoepker', 'Phoenix', 'Arizona', '85099');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('895', '75', 'Cottonwood', 'San Diego', 'California', '92110');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('896', '55', 'Nancy', 'Santa Rosa', 'California', '95405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('897', '63', 'Steensland', 'San Antonio', 'Texas', '78278');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('898', '62', 'Gulseth', 'Wilkes Barre', 'Pennsylvania', '18706');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('899', '26', 'Leroy', 'Troy', 'Michigan', '48098');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('900', '60', 'Truax', 'Indianapolis', 'Indiana', '46226');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('901', '17', 'Ramsey', 'Oklahoma City', 'Oklahoma', '73124');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('902', '62', 'Elka', 'Louisville', 'Kentucky', '40215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('903', '78', 'Burrows', 'Saint Louis', 'Missouri', '63150');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('904', '50', 'Fallview', 'Nashville', 'Tennessee', '37250');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('905', '25', 'Pearson', 'Dulles', 'Virginia', '20189');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('906', '23', 'Mendota', 'Jamaica', 'New York', '11407');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('907', '39', 'Eastlawn', 'Dallas', 'Texas', '75353');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('908', '43', 'Mayfield', 'Galveston', 'Texas', '77554');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('909', '32', 'Jenifer', 'Washington', 'District of Columbia', '20010');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('910', '92', 'Sherman', 'Boston', 'Massachusetts', '02203');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('911', '42', 'Hudson', 'Des Moines', 'Iowa', '50305');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('912', '47', '2nd', 'Los Angeles', 'California', '90101');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('913', '67', 'Buena Vista', 'Hicksville', 'New York', '11854');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('914', '60', 'Vermont', 'Fort Lauderdale', 'Florida', '33315');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('915', '28', 'Amoth', 'Dallas', 'Texas', '75251');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('916', '74', 'Sullivan', 'Atlanta', 'Georgia', '30301');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('917', '95', 'Hudson', 'Las Vegas', 'Nevada', '89140');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('918', '84', 'Oneill', 'West Palm Beach', 'Florida', '33416');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('919', '53', 'Carpenter', 'Los Angeles', 'California', '90055');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('920', '62', 'Eggendart', 'Gastonia', 'North Carolina', '28055');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('921', '27', 'Novick', 'Omaha', 'Nebraska', '68179');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('922', '13', 'Little Fleur', 'Baltimore', 'Maryland', '21265');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('923', '28', 'Buena Vista', 'Birmingham', 'Alabama', '35225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('924', '57', 'High Crossing', 'Colorado Springs', 'Colorado', '80945');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('925', '61', 'Burning Wood', 'Albany', 'New York', '12255');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('926', '8', 'Bunting', 'Oklahoma City', 'Oklahoma', '73114');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('927', '16', 'Thompson', 'Denver', 'Colorado', '80270');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('928', '70', 'Darwin', 'Chicago', 'Illinois', '60609');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('929', '65', 'Bowman', 'Washington', 'District of Columbia', '20088');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('930', '56', 'Old Gate', 'Omaha', 'Nebraska', '68179');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('931', '87', 'Warbler', 'Chicago', 'Illinois', '60663');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('932', '37', 'Forest', 'Houston', 'Texas', '77095');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('933', '77', 'Pawling', 'Mobile', 'Alabama', '36628');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('934', '25', 'Debs', 'Fairbanks', 'Alaska', '99790');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('935', '50', 'Becker', 'Montgomery', 'Alabama', '36134');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('936', '20', 'Magdeline', 'San Bernardino', 'California', '92424');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('937', '60', 'Katie', 'Knoxville', 'Tennessee', '37931');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('938', '60', 'Tennyson', 'Jamaica', 'New York', '11436');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('939', '71', 'Harbort', 'Fort Myers', 'Florida', '33994');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('940', '61', 'Redwing', 'Atlanta', 'Georgia', '31106');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('941', '84', 'Parkside', 'New York City', 'New York', '10292');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('942', '95', 'Hoepker', 'Pasadena', 'California', '91117');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('943', '60', 'Waywood', 'Lehigh Acres', 'Florida', '33972');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('944', '38', 'Buell', 'Naples', 'Florida', '34108');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('945', '71', 'Knutson', 'Philadelphia', 'Pennsylvania', '19109');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('946', '87', 'Banding', 'Washington', 'District of Columbia', '20260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('947', '45', 'Arrowood', 'Phoenix', 'Arizona', '85053');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('948', '28', 'Stang', 'Kalamazoo', 'Michigan', '49048');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('949', '26', 'Boyd', 'Reading', 'Pennsylvania', '19605');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('950', '78', 'Lindbergh', 'Sioux Falls', 'South Dakota', '57198');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('951', '14', 'Roth', 'Atlanta', 'Georgia', '31119');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('952', '97', 'Nobel', 'Spokane', 'Washington', '99260');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('953', '74', 'Hudson', 'Saginaw', 'Michigan', '48604');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('954', '2', 'Russell', 'Tulsa', 'Oklahoma', '74184');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('955', '11', 'Ohio', 'Washington', 'District of Columbia', '20078');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('956', '42', 'Almo', 'Albany', 'New York', '12205');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('957', '21', 'Trailsway', 'New York City', 'New York', '10039');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('958', '88', 'Holmberg', 'Atlanta', 'Georgia', '30311');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('959', '63', '7th', 'Jacksonville', 'Florida', '32236');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('960', '27', 'Anzinger', 'Columbus', 'Mississippi', '39705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('961', '25', 'Muir', 'Boston', 'Massachusetts', '02203');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('962', '85', 'Morrow', 'Newton', 'Massachusetts', '02162');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('963', '3', 'Fieldstone', 'New Orleans', 'Louisiana', '70160');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('964', '28', 'Kensington', 'Yonkers', 'New York', '10705');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('965', '59', 'Merchant', 'Salem', 'Oregon', '97306');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('966', '95', 'American Ash', 'Houston', 'Texas', '77070');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('967', '18', 'Transport', 'Tempe', 'Arizona', '85284');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('968', '66', 'Merchant', 'New York City', 'New York', '10203');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('969', '83', 'Logan', 'Lincoln', 'Nebraska', '68524');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('970', '88', 'Basil', 'Hicksville', 'New York', '11854');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('971', '73', '6th', 'Bloomington', 'Indiana', '47405');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('972', '26', 'Prairieview', 'Atlanta', 'Georgia', '31132');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('973', '58', 'Basil', 'Sacramento', 'California', '95823');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('974', '11', 'Badeau', 'Dayton', 'Ohio', '45414');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('975', '79', 'Charing Cross', 'Milwaukee', 'Wisconsin', '53225');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('976', '14', 'Holmberg', 'Wilkes Barre', 'Pennsylvania', '18706');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('977', '89', '3rd', 'Torrance', 'California', '90505');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('978', '62', 'Debra', 'Chicago', 'Illinois', '60614');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('979', '100', 'Schlimgen', 'Omaha', 'Nebraska', '68179');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('980', '92', 'Ohio', 'Charleston', 'West Virginia', '25326');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('981', '90', 'Bartelt', 'Columbia', 'South Carolina', '29240');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('982', '72', 'Victoria', 'Virginia Beach', 'Virginia', '23471');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('983', '53', 'Becker', 'Waco', 'Texas', '76711');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('984', '98', 'Westerfield', 'Boise', 'Idaho', '83727');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('985', '13', 'Johnson', 'Toledo', 'Ohio', '43615');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('986', '28', 'Hooker', 'Macon', 'Georgia', '31210');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('987', '74', '6th', 'Washington', 'District of Columbia', '20456');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('988', '62', 'Mariners Cove', 'Baltimore', 'Maryland', '21229');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('989', '93', 'West', 'El Paso', 'Texas', '79989');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('990', '43', 'Kennedy', 'Minneapolis', 'Minnesota', '55487');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('991', '90', 'Nelson', 'Laredo', 'Texas', '78044');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('992', '44', 'Dayton', 'Richmond', 'Virginia', '23213');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('993', '10', 'Schlimgen', 'Houston', 'Texas', '77010');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('994', '13', 'Hovde', 'Las Vegas', 'Nevada', '89125');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('995', '17', 'Express', 'Buffalo', 'New York', '14215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('996', '18', 'Welch', 'Dallas', 'Texas', '75372');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('997', '13', 'Calypso', 'Shawnee Mission', 'Kansas', '66215');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('998', '19', 'Crowley', 'Tulsa', 'Oklahoma', '74156');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('999', '42', 'Debra', 'Phoenix', 'Arizona', '85062');
INSERT INTO Suppliers (supplier_id, item_number, street, city, state, zip_code) VALUES ('1000', '54', 'Gale', 'Lansing', 'Michigan', '48930');

--# Users
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('1', 'jraubenheimer0', 'dThYC4CutNXm', '2/24/2023', '904-428-4017', 'Florry', 'Janelle', '5007666121573372', '648', '2/19/2023', 'Comanche', 'Saint Augustine', 'Florida', '32092');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('2', 'jmetcalfe1', 'NUV7RZ1yw', '8/31/2022', '302-807-9501', 'Olimpia', 'Jens', '3555318191750941', '668', '11/22/2022', 'Aberg', 'Wilmington', 'Delaware', '19810');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('3', 'bbirds2', 'OlUkF5pg7', '10/9/2022', '313-208-3661', 'Gris', 'Blakeley', '3543131068293613', '556', '8/14/2022', 'Pankratz', 'Detroit', 'Michigan', '48224');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('4', 'mharriss3', 'x2jwCUReeJ', '7/23/2022', '217-922-5785', 'Koren', 'Mart', '3586248833128466', '160', '10/26/2022', 'Browning', 'Springfield', 'Illinois', '62794');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('5', 'gbarkas4', 'f3GXiuQd', '2/26/2023', '303-252-6435', 'Claiborne', 'Giovanna', '201582481338295', '406', '11/7/2022', 'Northridge', 'Boulder', 'Colorado', '80310');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('6', 'aletson5', 'es7TamUid', '6/8/2022', '832-537-5154', 'Karia', 'Algernon', '564182216450088494', '155', '2/3/2023', 'Tomscot', 'Houston', 'Texas', '77266');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('7', 'ldebellis6', 'kHgWCD72s5n', '11/22/2022', '217-535-1545', 'Jess', 'Lulu', '63044779162488105', '260', '7/12/2022', 'Dottie', 'Springfield', 'Illinois', '62723');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('8', 'cgladyer7', 'FH1Lpgj7Ddd', '5/25/2022', '412-843-8324', 'Trixie', 'Camilla', '5641823096253318181', '895', '7/8/2022', 'Hagan', 'Mc Keesport', 'Pennsylvania', '15134');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('9', 'agideon8', 'qGXVfb', '12/15/2022', '559-698-0659', 'Phyllis', 'Amity', '6385536999376796', '350', '5/15/2022', 'Bellgrove', 'Fresno', 'California', '93750');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('10', 'kcurran9', 'BK7il3nap2Kj', '2/11/2023', '915-593-0377', 'Alfredo', 'Kristo', '6333168020420451', '796', '3/16/2023', 'Hagan', 'El Paso', 'Texas', '88589');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('11', 'plefevrea', 'D88ZNOCCOR', '3/5/2023', '423-987-8914', 'Gerladina', 'Pall', '67631433363256966', '314', '1/26/2023', 'Service', 'Chattanooga', 'Tennessee', '37410');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('12', 'alehrahanb', 'Rafo1jE', '7/12/2022', '817-187-2970', 'Lindy', 'Ailee', '3543635235600260', '1', '11/15/2022', 'Thierer', 'Fort Worth', 'Texas', '76129');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('13', 'cadiscotc', '2ntFt1p75', '11/3/2022', '571-514-8635', 'Allina', 'Cart', '3552618455760616', '735', '5/26/2022', 'Northview', 'Fairfax', 'Virginia', '22036');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('14', 'sbolesd', 'tl13Em0ay4EZ', '9/25/2022', '520-593-1055', 'Thatch', 'Say', '564182039262051280', '331', '2/28/2023', 'Declaration', 'Tucson', 'Arizona', '85720');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('15', 'sbudnke', 'Eez59eI', '10/25/2022', '310-935-8545', 'Klement', 'Sabina', '3543018108348988', '251', '6/27/2022', 'Vernon', 'Inglewood', 'California', '90310');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('16', 'pmoutonf', 'd57gtXZ2O4', '7/18/2022', '239-256-7861', 'Maggi', 'Paul', '5195201544535857', '797', '11/18/2022', 'Claremont', 'Fort Myers', 'Florida', '33994');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('17', 'jdurradg', 'QkWBxwJN3M', '3/14/2023', '305-509-8207', 'Jeffie', 'Jordan', '3547517514912101', '35', '12/31/2022', 'Hoepker', 'Hialeah', 'Florida', '33018');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('18', 'chanveyh', 'vLyefqp6Uq', '7/3/2022', '952-401-9017', 'Giacobo', 'Con', '3558122239314398', '776', '12/14/2022', 'Darwin', 'Young America', 'Minnesota', '55557');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('19', 'bdutsoni', 'O7baipPz7L', '10/22/2022', '904-545-7544', 'Bordie', 'Bobinette', '3587930430665789', '81', '4/4/2023', 'Straubel', 'Jacksonville', 'Florida', '32277');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('20', 'dmccrawj', 'kPsy2ybcb1', '10/25/2022', '804-372-9537', 'Bat', 'Daffi', '5602246942596891', '567', '10/13/2022', 'Clarendon', 'Richmond', 'Virginia', '23293');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('21', 'csimonittok', 'ezt7C49VtC3F', '7/4/2022', '210-574-6220', 'Mile', 'Cthrine', '3552501298747901', '33', '3/12/2023', 'Kim', 'San Antonio', 'Texas', '78205');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('22', 'bimlachl', 'kgvGNV5O5VVI', '7/12/2022', '785-182-4265', 'Neall', 'Brigit', '3566442966633392', '726', '6/25/2022', 'Reinke', 'Topeka', 'Kansas', '66622');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('23', 'dmiddism', 'V0rcih', '12/21/2022', '904-675-7607', 'Margaux', 'Delmer', '5108757883330321', '853', '5/30/2022', 'Springview', 'Jacksonville', 'Florida', '32244');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('24', 'jpitmann', 'TCRLZvqu3l', '1/2/2023', '504-431-2863', 'Anna-diana', 'Josh', '3577073125870786', '18', '10/17/2022', 'Bellgrove', 'New Orleans', 'Louisiana', '70179');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('25', 'tdavidsohno', 'bLkYDY11XS', '3/27/2023', '504-677-7057', 'Bunni', 'Tori', '6380920897822082', '544', '3/7/2023', 'Farragut', 'New Orleans', 'Louisiana', '70179');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('26', 'ngilmartinp', 'ld4JKmqG6L0j', '2/9/2023', '402-466-8441', 'Ellary', 'Nap', '3579059658193157', '248', '10/9/2022', 'Fallview', 'Omaha', 'Nebraska', '68110');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('27', 'cpretselq', 'd1db53', '9/12/2022', '406-648-5318', 'Archibold', 'Chrysa', '560225104304735337', '262', '12/16/2022', 'Lukken', 'Bozeman', 'Montana', '59771');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('28', 'gfortyer', '0pll0QXwRNgu', '8/17/2022', '786-400-8145', 'Teddie', 'Gussy', '4026777211719633', '895', '1/24/2023', 'Arapahoe', 'Miami', 'Florida', '33134');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('29', 'bglanderss', 'PP4PoZF', '5/30/2022', '314-807-5385', 'Mathew', 'Burt', '3535319723153773', '277', '3/5/2023', 'Comanche', 'Saint Louis', 'Missouri', '63196');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('30', 'sjoslint', '3g4USKDU7', '11/21/2022', '469-958-3471', 'Lillis', 'Sergeant', '30408371137737', '745', '4/23/2022', 'Oneill', 'Garland', 'Texas', '75044');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('31', 'tdibiasiou', 'l7tnoYD7t', '1/3/2023', '281-983-4661', 'Steffen', 'Tanhya', '6763143415886854', '583', '4/17/2022', 'Forster', 'Houston', 'Texas', '77025');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('32', 'baustinsv', 'ryscPKBKM', '8/22/2022', '570-838-7852', 'Therine', 'Brendan', '3545095355950540', '183', '5/14/2022', 'Clyde Gallagher', 'Scranton', 'Pennsylvania', '18505');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('33', 'hkirkbrightw', 'mJRZ5jC', '2/10/2023', '574-458-5577', 'Ransom', 'Harv', '5602210227190457', '620', '10/27/2022', 'Manitowish', 'South Bend', 'Indiana', '46699');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('34', 'ztembyx', 'rFTBuMF', '10/13/2022', '614-487-0943', 'Evy', 'Zorah', '5409209819032783', '994', '2/20/2023', 'Debs', 'Columbus', 'Ohio', '43220');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('35', 'tyitzowitzy', '3yLolS2pTVW', '12/22/2022', '518-455-5189', 'Billie', 'Thorn', '3589180427911741', '624', '4/17/2022', 'Eastlawn', 'Schenectady', 'New York', '12305');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('36', 'anaptonz', 'KS6tUKa', '4/17/2022', '214-294-1853', 'Sherye', 'Ashla', '36150375293652', '412', '1/19/2023', 'Victoria', 'Plano', 'Texas', '75074');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('37', 'aalliot10', 'iIR6WL', '2/27/2023', '702-138-6104', 'Karen', 'Aleksandr', '5020798588513584238', '800', '1/19/2023', 'Linden', 'Las Vegas', 'Nevada', '89178');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('38', 'vtremain11', 'ykFuw4ZmCEX', '9/15/2022', '419-150-6935', 'Care', 'Vincenz', '3588146804933575', '88', '7/22/2022', 'Mallory', 'Lima', 'Ohio', '45807');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('39', 'mpauley12', 'VdcuH4', '10/8/2022', '616-474-8805', 'Richy', 'Meagan', '6333142327387253060', '399', '7/3/2022', 'Rigney', 'Grand Rapids', 'Michigan', '49544');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('40', 'mmoens13', 'H0UDcGUMI', '9/1/2022', '941-155-6884', 'Sarajane', 'Marthena', '3584080397892894', '623', '12/15/2022', 'Sheridan', 'North Port', 'Florida', '34290');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('41', 'estuckow14', 'zUJAxeEq', '10/3/2022', '850-357-6115', 'Windy', 'Emelia', '4508321379987745', '392', '4/18/2022', 'Forest Dale', 'Pinellas Park', 'Florida', '34665');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('42', 'tcoghlan15', 'Cd6SeiL4', '12/17/2022', '207-633-4578', 'Gard', 'Tymothy', '67630079094630960', '678', '11/17/2022', 'Summit', 'Portland', 'Maine', '04109');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('43', 'gschulkins16', 'zGqQBOe4y', '9/2/2022', '214-691-3943', 'Maurise', 'Gal', '30224046239083', '93', '6/9/2022', 'Hauk', 'Dallas', 'Texas', '75353');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('44', 'arosita17', 'JL4IgKPRK7oz', '6/20/2022', '405-789-6855', 'Antoinette', 'Arney', '5100174574060431', '31', '1/12/2023', 'West', 'Oklahoma City', 'Oklahoma', '73157');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('45', 'dboland18', 'c8enWlqt', '3/3/2023', '303-938-8779', 'Pammie', 'Dewitt', '3544739964463541', '591', '4/23/2022', 'Cottonwood', 'Denver', 'Colorado', '80262');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('46', 'emillins19', 'omN0Ue2', '10/19/2022', '240-956-1807', 'Loydie', 'Edsel', '3550219393237189', '338', '7/5/2022', 'Meadow Ridge', 'Silver Spring', 'Maryland', '20918');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('47', 'bbarmby1a', 'EJe6P44m4aU', '2/5/2023', '505-677-7331', 'Clayton', 'Biron', '3559601958728689', '552', '10/5/2022', 'Calypso', 'Albuquerque', 'New Mexico', '87105');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('48', 'ewaldram1b', 'zu0FuQ', '7/14/2022', '704-734-1374', 'Chrissie', 'Emmet', '5018762598132801885', '192', '6/18/2022', 'Porter', 'Gastonia', 'North Carolina', '28055');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('49', 'tcronkshaw1c', '6ciFYjUf6', '4/14/2023', '757-971-2615', 'Major', 'Tracee', '4596876280390', '764', '2/23/2023', 'Union', 'Herndon', 'Virginia', '22070');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('50', 'dferrarin1d', '48i8gb', '6/1/2022', '713-235-3982', 'Muire', 'Dian', '564182862587736354', '112', '8/1/2022', 'Anthes', 'Houston', 'Texas', '77030');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('51', 'mbarnfather1e', 'hkhb2An9', '7/3/2022', '309-951-6886', 'Didi', 'Minne', '4405237543270319', '452', '9/2/2022', 'Mitchell', 'Peoria', 'Illinois', '61614');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('52', 'rrobley1f', 'K2CUaxqO5MV', '5/1/2022', '402-184-0287', 'Beverie', 'Rudyard', '374283084754019', '87', '2/26/2023', '7th', 'Omaha', 'Nebraska', '68117');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('53', 'bharower1g', 'O9Jtvv2', '12/16/2022', '770-309-6853', 'Cletus', 'Bryce', '30317291095976', '253', '1/26/2023', 'Dixon', 'Marietta', 'Georgia', '30061');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('54', 'llesaunier1h', '5d2EKhbkGtFj', '1/28/2023', '512-480-1252', 'Reid', 'Lee', '5423781109592322', '538', '3/9/2023', 'Pearson', 'Austin', 'Texas', '78721');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('55', 'dorhtmann1i', 'RSqAoTYAag1', '2/11/2023', '334-125-8474', 'Fleming', 'Delmar', '560221191457087438', '541', '4/22/2022', 'Union', 'Montgomery', 'Alabama', '36109');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('56', 'cspring1j', '4eFVIDjM', '6/20/2022', '407-205-6844', 'Olivia', 'Constantia', '3579680811121999', '495', '6/18/2022', 'Riverside', 'Orlando', 'Florida', '32808');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('57', 'aangliss1k', 'QEKdbsB', '12/18/2022', '605-640-4998', 'Archibold', 'Agathe', '4175009415116203', '911', '5/7/2022', 'Esker', 'Sioux Falls', 'South Dakota', '57188');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('58', 'eshrigley1l', '0yERjI5', '5/30/2022', '405-939-7315', 'Leora', 'Em', '201600916112570', '482', '8/6/2022', 'Golf Course', 'Oklahoma City', 'Oklahoma', '73142');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('59', 'adossantos1m', 'ovfVzp46', '8/16/2022', '202-257-5214', 'Sawyer', 'Auberta', '3554734907564411', '940', '1/4/2023', 'Oak', 'Washington', 'District of Columbia', '20551');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('60', 'leadington1n', 'x98xS2aE0UI', '3/25/2023', '504-934-0565', 'Casey', 'Lynnelle', '3559970203606341', '283', '6/25/2022', 'Browning', 'New Orleans', 'Louisiana', '70129');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('61', 'tcarlucci1o', 'whkeHhF7oWt', '10/5/2022', '915-320-4322', 'Rory', 'Tobe', '6767060859229594720', '655', '9/9/2022', 'Carberry', 'El Paso', 'Texas', '79911');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('62', 'mslemmonds1p', 'uRxtgoE7k2W', '1/21/2023', '661-435-9858', 'Yetty', 'Margette', '6761032811115673', '543', '2/13/2023', 'Spohn', 'Bakersfield', 'California', '93311');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('63', 'reckford1q', 'pD8KkNSDaPe', '4/27/2022', '859-257-2441', 'Jessalyn', 'Regen', '3541293545764871', '96', '1/4/2023', 'Kings', 'Lexington', 'Kentucky', '40586');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('64', 'schaudret1r', 'GwrXVUr5', '6/1/2022', '239-499-0907', 'Lauraine', 'Silvano', '30337857411839', '935', '1/17/2023', 'Randy', 'Fort Myers', 'Florida', '33906');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('65', 'iritson1s', 'fLn2MNmSxJAz', '8/21/2022', '918-831-5894', 'Dag', 'Iosep', '5018396368865086', '34', '7/29/2022', 'Ronald Regan', 'Tulsa', 'Oklahoma', '74141');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('66', 'kbynold1t', 'L9sUm0n5F', '5/25/2022', '937-957-7360', 'Cymbre', 'Krispin', '3540789344041081', '475', '9/6/2022', 'Macpherson', 'Dayton', 'Ohio', '45470');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('67', 'gmcguiney1u', 'G4AB6h', '12/15/2022', '509-570-6255', 'Osborne', 'Gipsy', '3570487621922981', '88', '12/26/2022', 'Monument', 'Spokane', 'Washington', '99205');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('68', 'mfarbrace1v', 'WSiJMl', '8/2/2022', '213-619-8211', 'Josefina', 'Margaretta', '5602239351428912', '546', '2/25/2023', 'Cambridge', 'Los Angeles', 'California', '90055');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('69', 'cbengtson1w', 'IIdjADG', '10/14/2022', '719-653-2761', 'Marsiella', 'Callean', '633396109652881292', '773', '9/4/2022', 'Loeprich', 'Colorado Springs', 'Colorado', '80951');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('70', 'rpapez1x', 'E4wKHh', '8/16/2022', '719-780-4048', 'Louisa', 'Roselle', '5518432788852639', '260', '6/9/2022', 'South', 'Denver', 'Colorado', '80209');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('71', 'nmackney1y', 'RIpWS1o', '1/18/2023', '502-843-1214', 'Flossy', 'Niels', '3566490190917172', '110', '4/21/2022', 'Butterfield', 'Louisville', 'Kentucky', '40205');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('72', 'chambers1z', 'e14d7F', '1/13/2023', '845-255-7013', 'Cris', 'Corny', '4041376400248', '248', '7/2/2022', 'Jenifer', 'White Plains', 'New York', '10633');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('73', 'cdengate20', '8fEKQ5rl', '6/24/2022', '217-713-7951', 'Beth', 'Charlotta', '4041598120145', '274', '3/31/2023', 'Buell', 'Champaign', 'Illinois', '61825');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('74', 'bsarjeant21', 'v6hionT', '12/8/2022', '904-335-3797', 'Jennifer', 'Bernadene', '4026194031152948', '176', '1/13/2023', 'Morrow', 'Jacksonville', 'Florida', '32204');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('75', 'dhrinishin22', '7Cw0aRFODK', '9/5/2022', '801-114-9717', 'Cordie', 'Derwin', '3579252367569631', '623', '12/2/2022', 'Melody', 'Salt Lake City', 'Utah', '84199');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('76', 'jwildt23', 't6qulQtM42', '2/17/2023', '609-650-5537', 'Gael', 'Jaquenetta', '6767662205155549', '575', '4/25/2022', 'Daystar', 'Trenton', 'New Jersey', '08638');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('77', 'emoran24', 'SDUANHTC86QB', '12/1/2022', '719-396-3916', 'Rosco', 'Elwira', '5490626190073294', '657', '2/26/2023', 'Texas', 'Colorado Springs', 'Colorado', '80940');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('78', 'uthursfield25', 'nRhu2Vd', '12/26/2022', '804-736-0004', 'Brod', 'Ulysses', '3530343108590974', '936', '6/24/2022', 'Barnett', 'Richmond', 'Virginia', '23260');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('79', 'cmceachern26', 'LbdmGK', '3/2/2023', '540-202-9234', 'Law', 'Crichton', '201862443793716', '132', '1/3/2023', 'Derek', 'Roanoke', 'Virginia', '24004');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('80', 'ccolbourne27', '9R3XPow1RmLF', '6/26/2022', '508-145-4900', 'Glynda', 'Clyve', '50383474989314983', '898', '5/30/2022', 'Ramsey', 'New Bedford', 'Massachusetts', '02745');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('81', 'agate28', 'TekB48D1I', '4/14/2023', '651-542-6168', 'Delmar', 'Avie', '3577124109448253', '675', '3/14/2023', 'Center', 'Saint Paul', 'Minnesota', '55108');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('82', 'dmerrill29', 'tYUpBG52', '6/16/2022', '504-394-0424', 'Carney', 'Darcey', '6759199785801536261', '69', '3/24/2023', 'Kipling', 'Metairie', 'Louisiana', '70005');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('83', 'ncudiff2a', 'NfRIKG1', '1/8/2023', '828-144-5688', 'Wolfy', 'Niall', '3557803769038371', '408', '4/14/2023', 'Elmside', 'Asheville', 'North Carolina', '28805');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('84', 'fcicerone2b', 'AsczIfxfc0jf', '3/1/2023', '254-483-5193', 'Saxe', 'Fletcher', '630427386958269757', '97', '2/13/2023', 'Sommers', 'Gatesville', 'Texas', '76598');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('85', 'afeatherbie2c', 'e7rixn5tqEWA', '11/6/2022', '713-860-2146', 'Natka', 'Aila', '67633196660446345', '790', '4/30/2022', 'Truax', 'Houston', 'Texas', '77260');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('86', 'bhaberfield2d', 'lRoRLtRWzL', '10/22/2022', '612-746-1038', 'Elnore', 'Bobinette', '5214938719296347', '302', '9/15/2022', 'Forest Dale', 'Minneapolis', 'Minnesota', '55480');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('87', 'mgypps2e', 'zIXJ43z', '10/18/2022', '228-106-8616', 'Kerwinn', 'Mathe', '3534509582129747', '243', '9/4/2022', 'Sunfield', 'Gulfport', 'Mississippi', '39505');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('88', 'abinch2f', '3J35Fq', '6/30/2022', '305-133-8224', 'Washington', 'Alfy', '4175008619471315', '456', '1/2/2023', 'Macpherson', 'Miami', 'Florida', '33190');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('89', 'amiddleditch2g', '0aBcyylRsqik', '8/16/2022', '360-971-6764', 'Lynnell', 'Alden', '6378464903602950', '781', '4/1/2023', 'Merchant', 'Vancouver', 'Washington', '98664');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('90', 'srittelmeyer2h', 'jBl9J8c', '3/24/2023', '406-101-7825', 'Melissa', 'Sherlock', '4175000755078822', '370', '2/23/2023', 'Jay', 'Bozeman', 'Montana', '59771');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('91', 'cmacconnal2i', 'eanbGS4Z89Gn', '11/23/2022', '713-381-5459', 'Napoleon', 'Chandler', '3569155411978892', '441', '8/3/2022', 'Anthes', 'Houston', 'Texas', '77228');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('92', 'callnutt2j', 'nWxEjlzhDyAz', '9/12/2022', '786-273-4427', 'Rosemarie', 'Chrysa', '3530764004331595', '7', '8/23/2022', 'Linden', 'Miami', 'Florida', '33190');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('93', 'goxbury2k', 'hV0puODhy', '9/7/2022', '208-752-2663', 'Leola', 'Guendolen', '30276266628320', '348', '8/7/2022', 'Nova', 'Boise', 'Idaho', '83727');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('94', 'itomaszynski2l', 'Vxf1EzP', '1/16/2023', '201-653-2571', 'Felicdad', 'Isaiah', '5500392626987601', '479', '2/21/2023', 'Northwestern', 'Jersey City', 'New Jersey', '07305');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('95', 'syellep2m', 'kgaf08GJh', '12/21/2022', '213-173-0849', 'Jereme', 'Salaidh', '5602256108341966', '986', '1/5/2023', 'Mcguire', 'Los Angeles', 'California', '90101');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('96', 'rwatkiss2n', 'ixjqllXdB', '6/21/2022', '419-723-8116', 'Sonnie', 'Raymund', '3547930163964341', '383', '4/27/2022', 'Dryden', 'Toledo', 'Ohio', '43605');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('97', 'gstrauss2o', 'kMtOp5', '7/16/2022', '863-875-0405', 'Garek', 'Geoffry', '633110223405538615', '829', '11/24/2022', 'Katie', 'Lehigh Acres', 'Florida', '33972');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('98', 'abosward2p', 'Pa9lHcHPyYhb', '9/28/2022', '404-987-5663', 'Eddie', 'Alberta', '5007666612287755', '290', '2/12/2023', 'Prairieview', 'Atlanta', 'Georgia', '31196');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('99', 'aebbutt2q', '21uYrFFfmAGQ', '6/17/2022', '816-115-2312', 'Clio', 'Amber', '6374715920361167', '448', '2/9/2023', 'Erie', 'Kansas City', 'Missouri', '64187');
INSERT INTO Users (user_id, username, password, date_made, phone_number, first_name, last_name, card_number, cvv, expiration_date, street, city, state, zip_code) VALUES ('100', 'chawkswell2r', 'z4rBQU6ead', '12/26/2022', '205-965-8620', 'Cookie', 'Christye', '3546670947341843', '75', '4/8/2023', 'Manufacturers', 'Birmingham', 'Alabama', '35295');
