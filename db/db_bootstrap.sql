create database Podify;

grant all privileges on Podify.* to 'webapp'@'%';
flush privileges;

use Podify;

CREATE TABLE Genre
(
    number_of_shows int,
    number_of_playlists int,
    podcast_name varchar(50) NOT NULL,
    genre_name varchar(50) PRIMARY KEY
);

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

CREATE TABLE Suppliers
(
    item_number int NOT NULL,
    street varchar(50),
    city varchar(50),
    state varchar(50),
    zip_code int,
    supplier_id int PRIMARY KEY
);

CREATE TABLE Inventory (
    item_number int NOT NULL,
    available_sizes varchar(50) NOT NULL,
    date_last_restock datetime NOT NULL,
    date_next_restock datetime NOT NULL,
    total_in_stock int PRIMARY KEY
);

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

CREATE TABLE Orders
(
    price int NOT NULL,
    customer_name varchar(50) NOT NULL,
    item_number int NOT NULL,
    order_number int PRIMARY KEY,
    CONSTRAINT fk_11
        FOREIGN KEY (item_number) REFERENCES Merchandise (item_number)
);

INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy', '1647065', '7311280', 'Podcast455');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama', '6979473', '5068111', 'Podcast874');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Musical', '3927314', '2095518', 'Podcast612');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Comedy|Thriller', '5018792', '3527873', 'Podcast649');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama|Romance', '2746109', '302751', 'Podcast061');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime|Drama', '3018360', '9133721', 'Podcast834');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery|Sci-Fi|Thriller', '600309', '9262767', 'Podcast760');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Romance', '2126352', '9427059', 'Podcast853');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Romance', '7833139', '6035756', 'Podcast689');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Mystery|Thriller', '5171637', '2534518', 'Podcast866');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery', '6485533', '918475', 'Podcast745');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure', '5034508', '9972148', 'Podcast512');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Drama', '4950531', '3609125', 'Podcast942');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime', '8844384', '1090388', 'Podcast873');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime|Drama|Film-Noir|Thriller', '920009', '231151', 'Podcast213');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Sci-Fi|War', '1520960', '5706337', 'Podcast405');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Sci-Fi', '5109896', '231384', 'Podcast694');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Adventure|Thriller|War', '5650253', '9059867', 'Podcast726');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Sci-Fi', '1414892', '4811124', 'Podcast857');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|War', '1135642', '6121415', 'Podcast870');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Musical|Romance', '2598092', '1513928', 'Podcast370');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure|Drama', '8119408', '8366515', 'Podcast430');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure|Fantasy|Thriller', '1970955', '7399665', 'Podcast432');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Drama', '1254265', '2284532', 'Podcast665');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Crime', '6028243', '206507', 'Podcast200');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Mystery|Thriller', '9045733', '9427732', 'Podcast330');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Comedy|Crime|Thriller', '4562857', '233855', 'Podcast261');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Romance|War', '60479', '4194558', 'Podcast482');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Documentary', '5184083', '632649', 'Podcast336');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Horror|Sci-Fi|Thriller', '6448816', '558637', 'Podcast529');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Horror|Romance', '770123', '1711897', 'Podcast428');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Mystery', '9887998', '9287187', 'Podcast414');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Sci-Fi|Thriller', '6877897', '6945390', 'Podcast603');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure|Animation|Children|Drama', '6341998', '6687263', 'Podcast447');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Animation|Children', '5326019', '1261302', 'Podcast537');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Animation|Children|Sci-Fi', '6722557', '2695073', 'Podcast252');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Horror|Sci-Fi|Thriller', '5468187', '2563107', 'Podcast849');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Animation|Children|Fantasy', '8165853', '7862783', 'Podcast819');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime|Drama|Romance|Thriller', '4114019', '5063636', 'Podcast839');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery|Thriller', '4069438', '4051714', 'Podcast753');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Fantasy|Romance', '4179158', '6017496', 'Podcast663');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Adventure|Animation|Children|Drama|Fantasy', '6246867', '6453510', 'Podcast006');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Drama|Mystery|Romance', '6732912', '5941096', 'Podcast738');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Fantasy|Horror|Thriller', '2218840', '3552734', 'Podcast074');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Comedy|Sci-Fi', '4674588', '3603527', 'Podcast263');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Action|Animation|Comedy', '7947272', '6903945', 'Podcast796');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Thriller', '3102692', '8748379', 'Podcast279');
INSERT INTO Genre (genre_name, number_of_shows, number_of_playlists, podcast_name) VALUES ('Crime|Drama|Mystery|Thriller', '3383654', '7731090', 'Podcast969');

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

INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (1,'twestmarland0','Dbd3eCxG8','2022-04-17 21:07:51','206-234-8189','tgostall0@altervista.org','Cy','Trudey',132498956,622,'2023-01-07 05:07:55','Scoville','Seattle','Washington',98195);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (2,'rbrotherhood1','INMxhb947iB','2022-10-15 19:20:12','719-271-8769','rspoors1@irs.gov','Kort','Rayshell',638163511,368,'2022-04-16 05:23:50','Mendota','Colorado Springs','Colorado',80940);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (3,'xjahan2','zlRdlwqAHA','2023-04-13 05:27:17','281-918-4224','xbrighty2@a8.net','Feliks','Xaviera',685069567,851,'2022-07-16 08:14:03','Nancy','Houston','Texas',77060);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (4,'emcgeachey3','9Cw868cb','2023-02-19 22:05:17','832-265-6167','ejurzyk3@youku.com','Bernelle','Emmye',413156952,732,'2022-10-24 09:51:29','Dwight','Houston','Texas',77201);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (5,'ddulieu4','0YOrNy','2022-10-22 22:19:18','619-385-7622','ddefont4@yandex.ru','Barrie','Dona',708810399,58,'2022-11-01 23:26:29','Mitchell','San Diego','California',92170);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (6,'aargabrite5','QzdfaO','2022-09-18 07:40:40','806-891-3578','acopozio5@t-online.de','Ruth','Anatollo',960132139,598,'2023-02-14 14:07:26','Marquette','Amarillo','Texas',79159);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (7,'abaggaley6','rCtZ0uJcl','2022-04-28 13:29:04','940-435-9995','amaving6@a8.net','Brande','Andras',273301757,443,'2022-12-30 14:02:32','Artisan','Wichita Falls','Texas',76310);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (8,'lcharrier7','33Ocli','2022-12-01 19:41:11','513-881-0056','lsigg7@bbb.org','Dottie','Leonelle',059971297,31,'2022-09-23 03:55:39','Caliangt','Cincinnati','Ohio',45233);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (9,'bhector8','4qKIIVj','2023-01-23 01:51:30','478-836-3745','bspurryer8@twitter.com','Vicki','Bruce',752862432,709,'2023-03-30 04:35:21','Ohio','Macon','Georgia',31217);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (10,'sbaline9','w0Pvzc','2022-10-02 20:57:17','215-913-6057','spimlett9@1und1.de','Sukey','Sadye',318168269,199,'2023-01-08 11:27:00','Northport','Philadelphia','Pennsylvania',19120);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (11,'egoldsbya','YZmB0dOi3Q6j','2022-05-17 12:32:48','405-328-0062','eclarksona@time.com','Edin','Emily',762537334,899,'2022-12-31 05:52:03','Lakewood','Oklahoma City','Oklahoma',73119);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (12,'hsambellb','HsqrvsI','2022-05-08 15:51:02','717-785-0105','hjanoutb@sciencedirect.com','Meir','Hanna',359818784,535,'2022-09-30 21:57:23','Farwell','Harrisburg','Pennsylvania',17126);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (13,'aarsonc','DdPYzowY','2022-07-29 08:30:05','404-202-1663','aingersonc@mysql.com','Randene','Albrecht',113677148,392,'2023-03-27 13:10:19','Mccormick','Gainesville','Georgia',30506);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (14,'atroddend','mKhyIQKU8','2022-07-07 23:13:39','703-350-3497','aglantond@chicagotribune.com','Duffie','Agata',325322220,815,'2022-07-28 12:24:47','Surrey','Alexandria','Virginia',22301);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (15,'phanwelle','DVZefxM','2023-01-02 21:46:39','706-456-6028','pferraresie@artisteer.com','Fleming','Pandora',559694438,573,'2022-11-20 17:34:27','Havey','Augusta','Georgia',30919);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (16,'gbradlyf','U6JhIh','2022-04-21 07:59:44','518-424-9157','gbaslerf@storify.com','Kingsly','Gabi',417640483,959,'2022-11-18 16:19:13','Brown','Albany','New York',12232);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (17,'nskiltong','oIdcC5LJ','2023-04-07 01:07:00','561-570-7042','nwithamg@drupal.org','Baxie','Nicolai',662083140,725,'2023-02-10 08:53:09','Lakewood Gardens','Boynton Beach','Florida',33436);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (18,'brandlesh','vnZvp6','2022-08-10 06:58:11','212-907-6728','bdemageardh@ycombinator.com','Neel','Blayne',410993439,922,'2023-03-25 15:48:42','Katie','New York City','New York',10249);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (19,'dnormanti','52tg34jg7iL','2023-02-05 13:51:08','405-811-5385','dsurri@booking.com','Byran','Dorita',996797993,6,'2022-07-21 16:54:32','Vera','Oklahoma City','Oklahoma',73179);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (20,'tscusej','WjZm9a0hBBC9','2023-01-08 19:36:44','661-322-9217','theardj@jalbum.net','Ced','Teodoro',454124247,801,'2022-05-25 01:35:51','David','Bakersfield','California',93386);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (21,'sozannek','XYs35qSR','2022-06-25 23:24:59','702-434-4152','syeellk@scribd.com','Rochell','Steffie',380723471,783,'2022-11-14 02:40:20','Linden','Las Vegas','Nevada',89145);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (22,'rborgnetl','tmIAVL5xPk','2022-06-19 22:45:52','352-895-5614','rbrombelll@biglobe.ne.jp','Marice','Rolfe',383730944,327,'2023-03-23 14:03:11','Little Fleur','Brooksville','Florida',34605);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (23,'mondrakm','IXgvyNajlIe','2022-04-17 17:43:24','916-652-6231','mmatticcim@about.me','Dianemarie','Mellisent',915949206,792,'2023-02-22 13:13:19','Schmedeman','Sacramento','California',94291);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (24,'ppidgeonn','5yBoCSF','2022-07-26 13:31:53','804-409-2361','pashfulln@yandex.ru','Annamaria','Peri',018374502,997,'2023-02-09 17:54:19','Nevada','Richmond','Virginia',23272);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (25,'bstrausso','vDeWTTd','2022-12-12 19:26:29','251-434-8868','bdoddo@google.co.jp','Bessy','Boigie',397846798,374,'2022-08-17 04:05:44','Norway Maple','Mobile','Alabama',36622);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (26,'vwaghornep','eSJhRXzE','2022-04-24 21:49:31','205-340-4376','vcroptonp@businesswire.com','Latia','Veda',844671846,245,'2022-12-28 07:59:09','Sunfield','Birmingham','Alabama',35279);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (27,'ipelosiq','xA8mVzcDnE7','2022-08-24 18:23:37','317-744-2136','ispirrittq@theglobeandmail.com','Wilt','Ilyse',551784145,979,'2023-01-02 09:10:45','Prairieview','Indianapolis','Indiana',46278);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (28,'jnotmanr','fLJRufBWDE1','2022-10-17 17:48:24','719-868-2518','jgarmansonr@ihg.com','Jonis','Jolene',361695644,857,'2023-01-14 21:38:21','David','Colorado Springs','Colorado',80995);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (29,'tcoggells','wHDJmwjF','2023-01-16 16:17:21','817-358-1712','tbilofskys@flickr.com','Salomi','Teresa',456788921,967,'2023-02-08 01:37:31','Harper','Denton','Texas',76210);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (30,'aellertont','ofcOuVeRi6','2023-01-09 22:56:48','646-146-2634','aheffordet@dot.gov','Theo','Ara',778439075,865,'2022-11-02 03:53:20','Prairieview','New York City','New York',10039);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (31,'pdidsburyu','5Q3JiBv2otfw','2022-09-30 17:10:26','513-644-0615','panyonu@examiner.com','Bernie','Papagena',874454077,921,'2022-06-19 14:00:15','Wayridge','Cincinnati','Ohio',45238);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (32,'gskeyv','lIjFcwk','2022-08-23 03:35:01','765-401-7309','ghardernv@bravesites.com','Madel','Gardie',362708237,487,'2022-11-19 04:22:07','Dexter','Lafayette','Indiana',47905);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (33,'dpurvisw','ZrIvw8hwK','2022-09-22 04:15:15','502-690-7037','dletcherw@usgs.gov','Georgeanna','Dee dee',664583703,581,'2023-01-21 20:11:04','Esch','Louisville','Kentucky',40280);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (34,'jthurstancex','VfHpE2i','2022-06-16 02:25:59','410-183-7994','jstandenx@economist.com','Carlynne','Joellyn',132819659,839,'2022-05-08 18:15:28','Commercial','Baltimore','Maryland',21216);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (35,'dtiey','OvK91plFV','2023-01-27 15:54:41','212-863-3002','dbaselliy@cdbaby.com','Edouard','Darcee',844680020,952,'2022-11-12 11:01:22','Hanover','New York City','New York',10125);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (36,'tmosebyz','M04WLh','2022-11-08 20:21:37','229-209-8627','tdagworthyz@list-manage.com','Calvin','Thaxter',816272426,693,'2022-04-19 13:56:38','Mesta','Valdosta','Georgia',31605);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (37,'vlaverick10','RzEq4CF','2022-08-18 09:35:25','817-223-3973','vsember10@bloglovin.com','Kathlin','Vin',246656478,431,'2022-04-17 15:30:33','Lillian','Fort Worth','Texas',76129);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (38,'tburnyeat11','ePMUZODjjt','2022-12-23 21:11:29','615-121-9546','tanelay11@is.gd','Koenraad','Tammy',317782554,161,'2023-03-08 23:09:31','Hermina','Nashville','Tennessee',37220);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (39,'ajennick12','lzLmB3','2022-06-18 09:00:24','315-746-2522','abillingsley12@hhs.gov','Juieta','Ada',628903389,86,'2022-10-24 21:20:38','Goodland','Syracuse','New York',13251);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (40,'jcrippes13','2qYoNBKQs','2022-10-12 14:40:01','773-786-1398','jabbot13@bloglovin.com','Cobb','Jenni',605138128,350,'2022-04-18 16:23:07','Aberg','Chicago','Illinois',60604);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (41,'mkinze14','rMFaiwBO','2023-01-21 23:49:42','917-341-1761','mnettleship14@cnet.com','Dorri','Maximilien',207354265,54,'2023-03-05 00:50:00','Algoma','New York City','New York',10034);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (42,'ehissie15','ywq9o3ygFUWy','2022-12-10 19:28:29','323-927-3695','ebartod15@csmonitor.com','Garrick','Emylee',828027317,994,'2022-12-10 19:49:08','Glendale','Long Beach','California',90810);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (43,'wkitley16','wUbnmCIZtM77','2022-11-04 06:11:58','520-298-1710','wagate16@netscape.com','Darya','Wrennie',048912712,175,'2022-05-04 10:34:08','Loeprich','Tucson','Arizona',85737);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (44,'ngilpillan17','M5cCCv','2023-03-05 21:16:00','406-577-9979','nbroadbere17@java.com','Brant','Nico',280183987,215,'2022-06-12 10:08:05','Daystar','Helena','Montana',59623);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (45,'cfoulks18','TfjuVC','2022-06-16 23:14:52','202-139-7986','chinckesman18@sogou.com','Devonna','Christen',637903960,361,'2022-06-13 19:59:08','Scott','Washington','District of Columbia',20409);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (46,'chillborne19','4i8PljqgsIih','2023-02-16 19:32:13','234-671-0447','crozet19@webmd.com','Laureen','Cecelia',178255978,685,'2022-09-20 19:44:20','Bunting','Canton','Ohio',44760);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (47,'cmonini1a','lLfOoP5','2022-09-23 03:22:14','571-240-7667','cgosling1a@fotki.com','Batholomew','Corrie',256945525,841,'2022-05-25 21:57:41','Algoma','Arlington','Virginia',22244);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (48,'koager1b','yB7UC7','2023-02-04 08:36:41','919-914-2701','kgayler1b@boston.com','Norby','Korey',347490482,834,'2023-01-14 16:55:03','Nancy','Raleigh','North Carolina',27626);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (49,'ashawe1c','QRUPrQJRaoGg','2022-08-30 20:58:02','952-332-1169','amussilli1c@domainmarket.com','Douglas','Antonia',843768298,594,'2022-05-01 21:47:50','Washington','Minneapolis','Minnesota',55407);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (50,'dspaxman1d','81JgjL2','2023-02-25 23:57:18','512-719-3839','dbarcke1d@ed.gov','Craggie','Donella',713878366,151,'2023-03-16 13:01:50','Monica','Austin','Texas',78710);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (51,'tchuter1e','vGOPkmxOVgR3','2022-07-24 09:47:51','386-131-8777','taskell1e@cbsnews.com','Reed','Tansy',188182861,897,'2022-11-21 15:22:23','Messerschmidt','Daytona Beach','Florida',32123);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (52,'eprahl1f','Yrs21C','2022-05-31 09:12:06','202-836-1055','emiddleditch1f@yandex.ru','Taylor','Edgar',815627391,400,'2022-05-11 20:35:02','Ruskin','Washington','District of Columbia',20057);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (53,'afarron1g','6nUx02s9xv','2023-01-09 16:12:27','410-116-3231','asharville1g@nhs.uk','Dionisio','Ambrose',021213993,972,'2022-10-04 19:57:57','Sutherland','Baltimore','Maryland',21265);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (54,'bniemiec1h','jyXduB','2022-06-16 13:18:53','702-208-1312','bdelhay1h@shinystat.com','Gwyneth','Berkie',823017564,610,'2022-12-14 15:40:38','Waxwing','Las Vegas','Nevada',89160);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (55,'sbeeze1i','UWqQmNwRDiX','2022-11-24 22:45:09','602-161-5531','sgowman1i@amazon.co.jp','Arnaldo','Shaw',457005752,699,'2022-10-27 01:26:22','Del Mar','Phoenix','Arizona',85040);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (56,'krevie1j','hqwbls','2022-09-28 07:14:01','530-529-9849','kcastiblanco1j@tumblr.com','Demetrius','Kaitlyn',523729019,7,'2023-01-03 06:40:47','Old Gate','South Lake Tahoe','California',96154);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (57,'abolam1k','Y3Bs4c','2023-01-08 02:49:05','973-992-1711','afrankling1k@weibo.com','Katuscha','Anatola',891166907,967,'2023-02-24 19:29:15','Everett','Paterson','New Jersey',07522);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (58,'scullnean1l','zZon4Fqm','2023-03-04 23:38:04','904-364-5308','smaccorkell1l@domainmarket.com','Alvan','Shelby',470652827,652,'2022-06-27 09:18:21','Hoffman','Jacksonville','Florida',32220);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (59,'rdare1m','4S3Ih6ihcTjO','2022-09-23 04:18:16','772-347-6986','rlabrow1m@shinystat.com','Star','Rania',685212778,751,'2022-10-22 10:52:55','Russell','Fort Pierce','Florida',34981);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (60,'rspearing1n','L1WC8vOK','2022-06-03 00:23:50','601-170-0217','rcharnick1n@scientificamerican.com','Sile','Rena',177885251,758,'2023-03-08 20:39:51','Anderson','Jackson','Mississippi',39210);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (61,'landrichak1o','BFRMAxY6rq','2022-07-17 07:09:40','216-477-6582','lflori1o@goo.ne.jp','Ronny','Leontyne',535990211,155,'2023-02-25 12:01:15','Carberry','Cleveland','Ohio',44105);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (62,'ftimblett1p','AodIGxLs','2023-01-03 08:32:40','971-481-9070','fpenwright1p@wikia.com','Camille','Frederico',749017337,594,'2022-10-28 13:09:54','Alpine','Portland','Oregon',97201);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (63,'krackstraw1q','2kebFlR','2022-08-14 05:58:55','509-550-7732','kgiggie1q@scribd.com','Colin','Karalynn',163318705,821,'2022-11-13 06:06:10','Tony','Spokane','Washington',99205);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (64,'jmethuen1r','2Uf2Xylj7','2022-07-26 14:52:21','816-465-3900','jannand1r@craigslist.org','Sheila','Janot',607207929,858,'2022-09-14 05:37:39','Merry','Kansas City','Missouri',64142);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (65,'rstroton1s','1mhgLas4Lpx','2023-01-03 17:23:17','501-505-0040','rmyhill1s@bloglovin.com','Sadie','Ryann',053275213,97,'2023-04-05 12:42:48','Clyde Gallagher','Little Rock','Arkansas',72209);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (66,'jsheivels1t','2p2IYFJnpzO','2022-08-02 15:37:57','281-126-9069','jtick1t@about.com','Adan','Josephina',745393760,620,'2023-04-06 20:21:17','Bellgrove','Humble','Texas',77346);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (67,'kdemaine1u','mJI9Ffa9','2022-05-18 10:10:51','210-293-7817','kgreenhowe1u@istockphoto.com','Gris','Kippy',611167671,316,'2022-12-04 06:59:14','Brentwood','San Antonio','Texas',78278);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (68,'eharyngton1v','TUJYs4cg','2022-07-09 22:53:57','215-932-0059','eashcroft1v@drupal.org','Ruthann','Enrico',515702250,190,'2022-08-17 16:52:59','Quincy','Philadelphia','Pennsylvania',19191);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (69,'dsecretan1w','dkmOtPaU','2022-05-22 10:08:24','309-395-8769','dgowry1w@apache.org','Erv','Dora',427790758,630,'2023-01-23 02:09:07','Cardinal','Carol Stream','Illinois',60351);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (70,'bbrasted1x','xOTOgF','2022-10-30 02:06:38','804-764-7145','bguage1x@wordpress.com','Tommie','Briant',131439632,205,'2022-05-07 01:10:06','Longview','Richmond','Virginia',23208);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (71,'aurien1y','vYOP1jPZ0H','2022-06-04 02:07:14','304-913-0556','ablunn1y@digg.com','Desiri','Andromache',050061398,261,'2023-03-23 16:58:52','Daystar','Charleston','West Virginia',25326);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (72,'bdowey1z','QTEX3Imig8','2023-02-04 16:02:34','808-863-6723','bdaintree1z@google.it','Malory','Barbe',438813801,444,'2022-07-05 14:04:26','Tennyson','Honolulu','Hawaii',96840);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (73,'sfeeney20','gH6WykFiZ','2023-04-15 02:44:52','717-844-7036','sgidley20@eventbrite.com','Cobby','Sawyer',817236876,422,'2022-05-23 16:46:21','Farragut','Harrisburg','Pennsylvania',17110);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (74,'bdallicoat21','kHFFBt','2023-01-06 08:28:03','616-655-4130','btomalin21@nps.gov','Hi','Bettina',311693822,701,'2022-08-15 11:39:31','Gale','Grand Rapids','Michigan',49518);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (75,'alenz22','rvGCJe','2022-10-04 17:24:34','402-962-5143','atyght22@imageshack.us','Judi','Aveline',680192649,204,'2022-07-16 18:27:50','Killdeer','Omaha','Nebraska',68144);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (76,'sstaddart23','nfvBcsIXo7V','2022-11-14 00:32:11','603-965-7154','sbloyes23@discovery.com','Savina','Saidee',839603931,977,'2022-07-11 23:00:42','Village','Manchester','New Hampshire',03105);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (77,'fdawney24','khlxXBCD','2023-03-31 04:14:42','305-531-5939','fsay24@prlog.org','Siegfried','Fredelia',340308680,772,'2023-01-27 15:13:59','Loomis','Miami','Florida',33129);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (78,'ebremen25','G5TnZZ','2022-06-22 20:44:20','203-247-7435','elalor25@weibo.com','Hanna','Elwin',331212017,635,'2022-09-26 09:28:46','Annamark','Stamford','Connecticut',06922);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (79,'cdawidowitz26','SfSnc1DxiZnt','2022-12-18 23:09:59','254-335-1490','cfellnee26@plala.or.jp','Waldemar','Codie',994621658,694,'2022-10-06 23:11:28','Oriole','Waco','Texas',76796);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (80,'bgoodliff27','CQsthHESK3','2023-03-07 18:24:50','702-619-8462','bchetham27@domainmarket.com','Monroe','Baxie',849266944,953,'2022-08-28 09:48:39','Cambridge','North Las Vegas','Nevada',89087);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (81,'htroth28','iekbQ4','2022-05-17 05:51:48','786-397-1305','hlapish28@com.com','Hillie','Howie',662458659,113,'2023-01-02 07:04:23','Kipling','Miami','Florida',33124);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (82,'bplain29','aJiiyh','2022-05-27 17:10:23','707-997-9667','bhavelin29@bloglovin.com','Eden','Brien',365736233,977,'2022-05-12 01:53:23','Emmet','Petaluma','California',94975);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (83,'aarsey2a','FIOA0eHPo','2022-05-29 14:23:29','251-258-4396','aivanishin2a@wunderground.com','Lane','Angus',400779165,426,'2022-09-07 03:32:14','Corry','Mobile','Alabama',36628);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (84,'eranklin2b','S1MZCqbkYMOP','2022-09-06 10:45:25','913-942-1685','ewhybray2b@ask.com','Judie','Esmeralda',382471545,992,'2022-05-30 09:13:31','Dapin','Kansas City','Kansas',66160);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (85,'igodain2c','IYkXd7uyAG','2023-04-03 16:07:30','804-548-0292','ipavlovic2c@flavors.me','Marc','Irina',403958845,427,'2022-05-18 13:44:36','East','Richmond','Virginia',23285);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (86,'jcicchelli2d','8J8ac9','2022-06-25 18:43:53','240-303-5278','jgude2d@diigo.com','Alley','Jaquelyn',959662652,847,'2022-09-27 22:24:52','Northfield','Gaithersburg','Maryland',20883);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (87,'bwishkar2e','dfnyW0ZFZ','2022-05-07 03:53:41','510-965-0865','bgwyllt2e@taobao.com','Wyn','Bria',674167292,526,'2023-03-04 04:11:48','Carey','Richmond','California',94807);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (88,'erizziello2f','M1jrpfnBg2','2022-10-04 21:41:15','913-822-9383','ebegin2f@bbb.org','Deane','Elisha',235368155,797,'2022-11-04 07:48:41','Stephen','Kansas City','Kansas',66160);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (89,'bupsale2g','QWZj9UPM85dr','2022-09-08 07:08:58','434-224-7668','bspringtorpe2g@senate.gov','Maurie','Barn',772120863,995,'2022-10-30 06:28:34','Crescent Oaks','Charlottesville','Virginia',22908);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (90,'ageorges2h','gIManWm','2022-10-25 04:51:39','801-626-3626','achrippes2h@illinois.edu','Aloin','Andria',815869900,965,'2023-03-23 19:01:02','Fisk','Salt Lake City','Utah',84199);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (91,'jmenghi2i','1p3HTR2GR','2022-05-20 04:14:52','916-764-1049','jcozins2i@ask.com','Giuditta','Jerrylee',285333793,726,'2023-02-18 06:53:28','Utah','Sacramento','California',94297);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (92,'cshyre2j','D1Sr2GmHpDMf','2023-02-23 05:57:10','706-970-6184','cchatan2j@netlog.com','Yard','Clim',783951825,986,'2022-08-17 23:27:23','Brown','Athens','Georgia',30610);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (93,'gmabson2k','4eVv4IqSQQW2','2022-09-25 20:01:11','757-984-4152','gbuckley2k@netvibes.com','Sergio','Gilbertine',244533379,564,'2022-05-15 19:07:01','Mandrake','Virginia Beach','Virginia',23464);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (94,'mblythe2l','8Tf60mYIJ7','2023-03-19 03:26:30','641-426-7003','makess2l@ehow.com','Barrett','Marta',873671190,255,'2022-10-08 10:42:48','Gina','Des Moines','Iowa',50315);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (95,'gsalter2m','OAtExkQFY7JI','2023-01-20 22:14:21','804-895-3700','ghambatch2m@ox.ac.uk','Livvy','Gert',962669742,281,'2023-03-07 02:01:48','Muir','Richmond','Virginia',23272);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (96,'kmcmenamin2n','xyqySIvq','2022-11-25 19:20:33','407-490-2529','kjurek2n@xrea.com','Mylo','Kaila',099324577,17,'2022-11-05 04:19:37','Stang','Orlando','Florida',32891);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (97,'bboate2o','3hagSh81Z','2022-08-10 03:04:40','561-447-3513','bgerssam2o@dagondesign.com','Cristabel','Brose',423430918,535,'2022-12-03 10:58:04','Little Fleur','West Palm Beach','Florida',33416);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (98,'wmockford2p','KTqFvAJWr','2022-06-07 21:04:16','281-877-5531','warlt2p@163.com','Brody','Welbie',092391685,328,'2022-12-17 03:39:59','Hermina','Houston','Texas',77050);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (99,'hdiamond2q','5FZj9DF','2023-02-15 14:28:11','203-729-0328','hpogosian2q@pcworld.com','Merry','Herbie',389037876,119,'2023-04-04 17:35:21','Algoma','Fairfield','Connecticut',06825);
INSERT INTO Creators(creator_id,username,password,date_made,phone_number,email_address,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (100,'fchiommienti2r','yQpnn9OpmopM','2023-01-07 02:13:41','770-634-1461','fpetracco2r@instagram.com','Sam','Florentia',400317278,147,'2022-04-28 01:44:29','High Crossing','Marietta','Georgia',30061);

INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-02 23:16:14',7183114,'Animation|Children',32,40,'Podcast493');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-26 05:33:18',2248363,'Drama|War',11,45,'Podcast289');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-09 13:09:47',2702235,'Comedy',52,37,'Podcast622');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-11 18:29:37',8847262,'Horror|Mystery|Thriller',84,46,'Podcast303');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-09-09 11:16:55',900105,'Drama|Romance',19,15,'Podcast640');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-02-18 16:25:38',943592,'Drama|Sci-Fi',15,16,'Podcast437');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-09-29 13:22:14',7031386,'Drama|Mystery',39,49,'Podcast483');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-12-12 21:39:29',906275,'Comedy|Romance',99,47,'Podcast376');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-05-01 05:24:04',1335975,'Comedy|Romance',37,45,'Podcast644');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-08-23 11:51:28',3192537,'Comedy|Crime',59,23,'Podcast894');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-05-22 00:04:43',1959628,'Action|Comedy|Crime|Thriller',77,28,'Podcast431');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-07 09:25:56',6186596,'Crime|Drama|Film-Noir|Thriller',11,97,'Podcast585');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-02-28 01:51:35',9320443,'Adventure|Animation|Children|Drama',96,39,'Podcast893');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-05-19 09:38:30',4500286,'Drama|Mystery',32,87,'Podcast157');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-07 19:12:25',2228079,'Comedy|Romance',53,34,'Podcast375');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-21 03:16:42',4287117,'Horror|Sci-Fi',38,84,'Podcast802');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-02-27 01:04:31',7349970,'Drama|Sci-Fi',82,13,'Podcast390');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-19 22:04:31',20650,'Drama|Romance',12,30,'Podcast338');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-17 18:57:24',6346114,'Drama',88,69,'Podcast202');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-30 19:32:12',38354,'Horror|Sci-Fi|Thriller',42,6,'Podcast346');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-12-02 06:43:25',5218204,'Adventure',23,4,'Podcast586');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-06-27 01:24:27',4992095,'Drama',21,63,'Podcast168');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-08-24 22:49:27',7398610,'Horror|Mystery|Thriller',42,10,'Podcast445');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-06-13 15:33:21',3237148,'Comedy',47,60,'Podcast636');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-29 18:38:56',3433508,'Adventure|Animation|Children|Drama',11,12,'Podcast865');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-04-30 12:30:30',5686949,'Drama',15,8,'Podcast193');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-04-10 18:35:57',9536216,'Comedy|Drama',85,86,'Podcast635');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-04 05:53:24',6626167,'Drama|Musical',84,58,'Podcast031');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-11 06:38:51',6755066,'Comedy',72,84,'Podcast591');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-12-01 13:19:26',3242312,'Drama',78,14,'Podcast100');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-02-06 21:07:01',132989,'Adventure|Fantasy|Thriller',94,27,'Podcast021');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-04-10 10:18:24',5482470,'Adventure|Drama',56,97,'Podcast186');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-12 10:15:23',6295014,'Drama',31,99,'Podcast096');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-06 14:01:11',4884472,'Drama',6,4,'Podcast654');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-06-08 05:30:43',8326371,'Drama',21,83,'Podcast665');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-20 21:30:08',293665,'Action|Comedy|Crime|Thriller',2,27,'Podcast994');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-08-07 15:01:04',4388794,'Drama|Romance',96,5,'Podcast034');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-29 12:35:09',4781640,'Drama|Romance',27,88,'Podcast123');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-08-05 05:41:25',3988548,'Horror|Mystery|Thriller',61,87,'Podcast501');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-06-06 05:26:44',9620828,'Thriller',45,43,'Podcast199');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-14 14:11:09',4827174,'Action|Adventure|Thriller|War',7,98,'Podcast637');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-25 18:23:31',7499684,'Comedy|Romance',94,3,'Podcast051');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-25 07:41:09',3906702,'Adventure|Drama',54,99,'Podcast511');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-06-01 02:21:15',1089155,'Comedy|Drama|Romance',96,91,'Podcast957');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-06-10 10:29:01',9529623,'Horror|Sci-Fi|Thriller',86,10,'Podcast218');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-09-06 21:01:25',4198472,'Horror|Mystery|Thriller',18,96,'Podcast773');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-02-26 02:25:48',6286755,'Animation|Children',53,27,'Podcast666');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-05-02 21:07:25',7422830,'Comedy|Drama|Romance',44,45,'Podcast771');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-29 21:09:46',5460900,'Comedy|Drama',35,17,'Podcast482');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-12-22 04:50:44',4635541,'Comedy|Drama',27,60,'Podcast151');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-22 17:05:32',3309515,'Drama',15,24,'Podcast767');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-27 08:45:50',7395837,'Comedy',11,41,'Podcast078');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-12-03 00:27:30',1350588,'Horror|Sci-Fi|Thriller',6,46,'Podcast839');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-08 11:00:27',7483432,'Drama',41,54,'Podcast702');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-04-27 04:41:15',4446623,'Drama|Mystery|Sci-Fi|Thriller',58,75,'Podcast809');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-25 11:06:50',9197098,'Drama',79,22,'Podcast335');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-06-26 20:52:10',7597929,'Drama',67,76,'Podcast672');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-08-03 21:13:36',555991,'Drama|Horror|Romance',78,47,'Podcast403');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-17 07:15:39',2822515,'Drama|Romance',28,24,'Podcast663');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-08-04 13:03:39',2330635,'Mystery|Thriller',34,71,'Podcast770');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-22 09:40:15',6077628,'Action|Comedy|Thriller',65,15,'Podcast693');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-28 02:22:39',4573877,'Animation|Children',36,10,'Podcast126');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-01 09:56:20',5974111,'Drama',26,28,'Podcast513');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-26 21:16:47',5413041,'Drama|Mystery',1,74,'Podcast716');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-02-07 09:39:40',5813008,'Adventure|Fantasy|Thriller',58,24,'Podcast871');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-23 07:47:05',1004239,'Documentary',47,92,'Podcast069');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-08-16 03:44:58',4519873,'Comedy',21,82,'Podcast613');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-04-13 06:22:43',8528042,'Comedy',64,83,'Podcast140');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-06-07 03:09:08',6897486,'Documentary',68,94,'Podcast824');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-28 20:22:28',4197180,'Action|Animation|Comedy',15,22,'Podcast277');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-29 00:53:22',9278509,'Drama|Romance',59,25,'Podcast861');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-01 11:35:05',7341945,'Drama|Fantasy|Romance',69,57,'Podcast368');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-15 02:16:37',334809,'Drama',58,2,'Podcast845');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-12-29 01:19:43',6250608,'Comedy',97,60,'Podcast606');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-14 07:03:55',5384011,'Horror|Sci-Fi',75,89,'Podcast758');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-22 12:41:28',2734306,'Action|Animation|Children|Sci-Fi',66,33,'Podcast700');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-26 06:23:25',3322860,'Fantasy|Horror|Thriller',30,64,'Podcast502');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-22 02:47:45',1225299,'Drama|Mystery|Romance',67,63,'Podcast106');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-13 11:48:19',2167922,'Drama',69,51,'Podcast164');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-13 21:51:40',7662875,'Adventure|Animation|Children|Drama',88,73,'Podcast440');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-13 16:50:55',5771024,'Drama',24,76,'Podcast911');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-05-01 03:45:46',9736416,'Mystery',72,3,'Podcast023');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-04-27 15:13:29',3491968,'Crime|Drama|Romance|Thriller',45,44,'Podcast537');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-05-08 09:32:16',6959882,'Comedy|Drama|Romance',83,91,'Podcast612');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-08 16:55:46',6103967,'Comedy|Drama|Romance',30,22,'Podcast541');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-31 07:48:11',690349,'Drama',86,68,'Podcast536');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-09-20 21:26:46',2741344,'Adventure|Animation|Children|Drama|Fantasy',4,87,'Podcast177');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-08-26 18:50:13',6685589,'Comedy|Drama',59,14,'Podcast793');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-10-06 20:12:43',8994931,'Documentary',75,69,'Podcast469');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-03-19 10:08:47',6711436,'Adventure|Drama',11,44,'Podcast489');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-02-28 12:19:53',1465357,'Drama|Romance',41,62,'Podcast514');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-02-04 19:56:07',6840147,'Drama|Musical|Romance',7,85,'Podcast189');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2023-01-02 16:20:21',1899884,'Documentary',36,26,'Podcast131');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-07-05 15:33:18',6695934,'Drama|Fantasy|Romance',68,78,'Podcast898');
INSERT INTO Podcasts(release_date,number_of_episodes,genre_name,episode_number,creator_id,name) VALUES ('2022-11-24 11:37:08',2908593,'Drama|Mystery',47,14,'Podcast647');

INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (1,'cradki0','yVxaAxkT','2022-10-14 15:08:34','480-542-7545','Efren','Carlyle',409734391,695,'6/4/2022','Merry','Apache Junction','Arizona',85219);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (2,'cmixer1','7O3Gi8','2022-12-08 17:25:57','203-138-7580','Javier','Charline',887279590,799,'3/18/2023','High Crossing','Norwalk','Connecticut',06859);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (3,'cgullefant2','yxHjaM','2022-06-02 13:03:36','585-998-3637','Cassi','Cordelia',998168637,373,'12/25/2022','Paget','Rochester','New York',14614);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (4,'lbrittan3','unkaqXWqy','2022-08-27 21:32:50','804-672-8954','Gallard','Leonore',617387126,569,'12/17/2022','Cody','Richmond','Virginia',23289);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (5,'dginley4','TtGXuTSLQf','2022-05-02 00:06:19','804-754-6066','Dahlia','Drugi',264180382,396,'7/29/2022','Mallard','Richmond','Virginia',23293);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (6,'gcaush5','gQEJuVdk','2022-12-13 17:12:24','406-101-3082','Davin','Guenevere',222399141,764,'5/2/2022','Jackson','Missoula','Montana',59806);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (7,'gpourveer6','iIZDwuwG','2022-07-12 11:32:21','228-499-3416','Timoteo','Georges',863018286,591,'7/12/2022','Oakridge','Biloxi','Mississippi',39534);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (8,'eclac7','3bIUQc1M6alr','2022-08-30 18:25:30','253-558-3207','Tobin','Eadie',581059394,144,'3/9/2023','Summit','Seattle','Washington',98166);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (9,'cbatho8','B7hYdhH','2023-03-14 04:08:37','212-339-2074','Glenda','Corrie',747658970,225,'3/11/2023','Hoard','New York City','New York',10292);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (10,'egepheart9','j4AImEDxsFKZ','2023-02-02 17:20:23','361-378-1579','Josie','Ellerey',096081883,921,'5/10/2022','Eggendart','Corpus Christi','Texas',78405);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (11,'cemlena','S8NQTJC5e1ns','2023-03-23 20:05:00','916-869-8057','Nonnah','Carline',683838799,192,'10/16/2022','Jenna','Sacramento','California',95838);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (12,'wwressellb','sP2NXO','2022-06-24 02:28:47','717-357-5941','Livvie','Willdon',263453491,928,'1/15/2023','Glacier Hill','Harrisburg','Pennsylvania',17110);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (13,'jneubiginc','LFEK4aB4','2022-11-19 04:52:18','406-419-3244','Meggie','Jerri',378802170,322,'8/22/2022','Crowley','Bozeman','Montana',59771);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (14,'kismirniogloud','Vf1KMXNJZ','2022-11-29 18:09:46','917-832-9495','Pattie','Kerry',413739184,721,'11/10/2022','Logan','New York City','New York',10110);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (15,'mmashale','FxGpmuU','2022-05-28 19:46:05','240-102-1394','Aaren','Molli',633624419,817,'1/20/2023','Steensland','Bowie','Maryland',20719);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (16,'lmccromleyf','W67A2PKnjFEZ','2022-12-24 10:28:36','503-979-4345','Josie','Letizia',723722130,312,'6/26/2022','Schiller','Portland','Oregon',97211);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (17,'ctrubshawg','duCExa','2022-12-22 03:35:25','972-860-5269','Harper','Charlotte',424879691,290,'9/5/2022','Cascade','Dallas','Texas',75226);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (18,'lmurrisonh','1AQSgCkt','2022-11-26 16:42:45','865-760-2010','Ryun','Lovell',789536102,638,'2/3/2023','David','Knoxville','Tennessee',37919);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (19,'dpaigei','JlCAX5nB','2023-01-04 13:13:08','719-293-5297','Homere','Demetri',892034537,260,'3/21/2023','Acker','Colorado Springs','Colorado',80920);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (20,'sloviej','FCoSWIS1qe','2023-03-09 18:34:14','602-330-2570','Darrick','Selina',251847806,744,'9/27/2022','Duke','Phoenix','Arizona',85035);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (21,'cdockrillk','BmjbxXj4x3Pm','2023-03-26 08:49:52','704-638-3830','Lion','Carl',188811074,259,'2/3/2023','Loomis','Charlotte','North Carolina',28278);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (22,'shayterl','dV3bUS62','2022-11-09 18:50:03','845-309-9598','Marigold','Shaun',953693487,524,'1/14/2023','Warrior','White Plains','New York',10606);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (23,'bsparkem','EH2nlCm','2022-08-21 04:50:27','619-912-6595','Lory','Buddie',802022043,820,'12/29/2022','Fulton','San Diego','California',92160);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (24,'mdanitn','jgRuBVci','2022-09-03 19:33:03','904-395-2876','Tildie','Marjory',788994519,387,'2/27/2023','Brentwood','Jacksonville','Florida',32236);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (25,'agregorowiczo','YCgCM129zp45','2022-09-13 12:20:23','904-418-6774','Ewell','Almira',858842419,419,'5/31/2022','Elmside','Jacksonville','Florida',32209);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (26,'leloip','cvDKe2S0','2022-05-02 07:27:32','813-348-1346','Antonino','Lyndel',417910476,242,'12/5/2022','Express','Tampa','Florida',33620);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (27,'gwadleyq','29pAaoT9t0','2023-03-08 07:46:29','563-284-0864','Udall','Gunilla',284534956,882,'4/2/2023','Lerdahl','Davenport','Iowa',52809);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (28,'nlittletonr','XrGrgUg','2022-04-19 20:26:20','571-863-9818','Colver','Nicolle',456697109,289,'4/22/2022','Merry','Arlington','Virginia',22244);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (29,'sbeterisss','rHZqqPYFY3D7','2022-06-11 19:32:27','504-392-2584','Angel','Skye',646637926,173,'12/27/2022','Raven','New Orleans','Louisiana',70149);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (30,'fsanbrookt','6W4UojN8','2022-09-26 12:24:07','414-694-7606','Ronnie','Filide',316542690,918,'10/6/2022','4th','Milwaukee','Wisconsin',53285);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (31,'crylattu','ZFbtlIW','2023-02-08 04:58:05','757-289-9866','Avrit','Coretta',285244738,369,'3/23/2023','Lukken','Hampton','Virginia',23663);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (32,'lpatershallv','n0M3IaLh','2022-06-20 10:42:01','386-138-2170','Gwenni','Lissie',683078698,768,'9/5/2022','Dawn','Daytona Beach','Florida',32128);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (33,'hclearsw','rHJ6RC9','2022-11-13 13:47:02','816-865-4418','Sidonia','Hayyim',561249520,728,'6/13/2022','Jenifer','Shawnee Mission','Kansas',66205);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (34,'bfrancktonx','tcFNiwO','2022-06-10 08:59:23','720-694-2644','Moishe','Bryce',226953118,100,'2/4/2023','Kim','Denver','Colorado',80223);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (35,'kschettiniy','oLL34dkIGzl','2023-01-13 12:13:21','202-348-2338','Der','Karlis',615529604,882,'3/3/2023','Grayhawk','Washington','District of Columbia',20238);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (36,'rlorencz','8OGDlVZU','2022-06-26 22:28:31','813-133-1879','Lelia','Ruggiero',094292333,899,'12/11/2022','Russell','Tampa','Florida',33620);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (37,'aabade10','O1LSWTlD8sAL','2023-04-07 10:59:30','626-414-4336','Winna','Aylmer',276688178,179,'9/14/2022','Old Shore','Pasadena','California',91117);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (38,'vbambrugh11','TAHd33KJeqG8','2022-12-25 20:11:46','206-377-1254','Winnie','Virge',390809708,282,'10/31/2022','Reinke','Seattle','Washington',98185);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (39,'acurrin12','f2hCQ9KM4','2023-04-02 12:08:33','803-217-9816','Nahum','Anetta',056645639,150,'4/28/2022','Park Meadow','Columbia','South Carolina',29208);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (40,'fadmans13','gwOES2u','2022-07-02 23:34:13','971-223-2985','Dagmar','Ferguson',653716911,352,'6/23/2022','Texas','Portland','Oregon',97271);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (41,'krussi14','E2rm71','2022-06-18 16:02:45','310-308-1164','Emmit','Karolina',879164365,470,'10/25/2022','Center','Inglewood','California',90398);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (42,'rrizzardini15','kRc54OI','2022-10-29 18:10:16','952-620-6238','Drucie','Randolph',861186802,655,'7/21/2022','Redwing','Young America','Minnesota',55573);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (43,'avoysey16','mQ9hJxXTx','2022-06-12 02:12:53','804-316-0760','Roseanna','Amalie',511236003,146,'1/6/2023','Nancy','Richmond','Virginia',23213);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (44,'adogg17','QItppK','2023-01-12 18:24:18','704-659-4000','Torrey','Ali',300293948,368,'10/3/2022','Lakeland','Gastonia','North Carolina',28055);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (45,'gkaveney18','zO4HtLTm6Vv','2022-04-26 20:19:29','253-361-2946','Meryl','Gwendolen',664471271,972,'5/17/2022','Service','Tacoma','Washington',98447);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (46,'bexeter19','9n5UGX5','2022-08-26 00:00:09','803-903-6215','Baudoin','Bamby',705392325,319,'6/22/2022','Dryden','Aiken','South Carolina',29805);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (47,'achallen1a','b7YbCgG5A','2022-10-02 07:41:33','901-592-3944','Georgianne','Andros',543602797,867,'1/4/2023','Kingsford','Memphis','Tennessee',38119);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (48,'dmiddle1b','sbxgrf','2022-07-27 14:37:07','208-471-0399','Willy','Devin',325585236,70,'10/22/2022','Kinsman','Boise','Idaho',83727);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (49,'mhawthorne1c','9yz5ztKI0E','2022-07-31 05:24:29','864-287-2351','Rene','Morris',979008580,320,'8/1/2022','Eagle Crest','Greenville','South Carolina',29615);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (50,'ksherer1d','8a9B27','2023-03-11 03:55:19','702-311-1164','Rosy','Krystal',721094306,803,'3/22/2023','Continental','Las Vegas','Nevada',89160);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (51,'nwinridge1e','aMi7oA','2022-09-20 14:06:16','317-755-7670','Callie','Neila',962807573,899,'12/15/2022','Roxbury','Indianapolis','Indiana',46221);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (52,'lskamell1f','CDfY2Nj','2023-04-12 03:03:42','309-368-2776','Gaspard','Lannie',536001000,3,'9/27/2022','High Crossing','Peoria','Illinois',61605);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (53,'dgagie1g','bqYpFA2jw','2022-10-13 03:51:51','810-525-2465','Willow','Dyann',072748492,236,'10/15/2022','Mockingbird','Flint','Michigan',48555);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (54,'tbraunthal1h','FFOrGp1b','2023-01-26 18:07:20','530-254-8818','Reg','Tanya',673325159,563,'11/19/2022','New Castle','South Lake Tahoe','California',96154);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (55,'gabrahams1i','hj9Z1X','2022-09-13 16:59:18','515-573-3555','Pansie','Giffer',184220318,729,'6/5/2022','Derek','Des Moines','Iowa',50981);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (56,'lhumbles1j','QpvFLBuRZ','2022-09-21 22:26:10','203-184-5477','Jard','Lauryn',531701010,935,'7/2/2022','Lyons','New Haven','Connecticut',06520);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (57,'vchaimson1k','h98TQ3S','2022-06-23 03:58:16','812-156-7332','Tammie','Virginie',311080557,310,'3/13/2023','Michigan','Evansville','Indiana',47719);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (58,'bollivier1l','Flps7Ss2','2023-03-19 04:44:32','716-639-3368','Valentine','Birch',349829014,540,'2/25/2023','2nd','Buffalo','New York',14205);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (59,'mbaskerfield1m','qUZk0CyqaYL','2022-06-20 22:50:25','337-394-9779','Sapphire','Mellisa',240201821,527,'7/12/2022','Di Loreto','Lake Charles','Louisiana',70616);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (60,'zhehnke1n','gOeXfpmjtQ','2022-12-15 03:34:19','202-867-4930','Hank','Zoe',637701153,647,'7/25/2022','Mesta','Washington','District of Columbia',20022);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (61,'nspaughton1o','y02G9Uk0','2022-09-05 10:18:17','234-886-6565','Raven','Neddy',883835571,511,'7/1/2022','Havey','Akron','Ohio',44393);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (62,'lferriday1p','KAOZxIR','2022-12-02 15:58:04','915-403-9653','Yorgos','Leann',137250565,611,'4/5/2023','Quincy','El Paso','Texas',79911);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (63,'enutkins1q','mWbwyl','2022-12-16 11:47:06','915-918-5687','Marcela','Elijah',929702132,168,'8/19/2022','Old Gate','El Paso','Texas',79994);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (64,'tgitthouse1r','sED1gq','2023-03-18 03:10:35','573-532-2281','Tamiko','Traver',547985496,853,'1/21/2023','Debra','Jefferson City','Missouri',65110);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (65,'ccrookshank1s','eTne5e','2022-06-28 19:52:22','806-189-6542','Eulalie','Caren',682625050,711,'3/13/2023','Melody','Amarillo','Texas',79116);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (66,'rdomingues1t','G1A4kogubPB','2023-03-24 23:42:51','571-355-5084','Nicola','Reade',748628569,798,'4/18/2022','Doe Crossing','Sterling','Virginia',20167);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (67,'kaprahamian1u','oLWfHFXQiz','2023-04-14 14:43:10','302-147-1819','Darrick','Kennith',835488035,272,'5/22/2022','Loftsgordon','Newark','Delaware',19714);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (68,'kilden1v','i9cZRTJzvE6c','2022-07-12 21:34:19','850-581-3544','Morrie','Karita',767398651,162,'12/5/2022','New Castle','Tallahassee','Florida',32399);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (69,'dleblanc1w','cynlTA32U','2022-12-24 03:50:50','513-786-9416','Edy','Darla',947061090,975,'11/7/2022','Roxbury','Columbus','Ohio',43215);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (70,'vranscomb1x','mCWhgc57bFY','2023-03-12 14:59:16','702-923-6152','Fern','Valma',873274925,809,'11/17/2022','Jenifer','Las Vegas','Nevada',89150);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (71,'smacmarcuis1y','fDXmQZ2Kn6B','2022-05-04 21:26:22','260-753-9069','Agneta','Salvatore',937597424,270,'12/27/2022','Miller','Fort Wayne','Indiana',46852);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (72,'jadamovitz1z','tc0L1F73','2022-10-14 14:49:00','804-975-7620','Hercules','Jorie',901604580,966,'12/1/2022','Jana','Richmond','Virginia',23289);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (73,'fheugel20','y7OTEV','2022-07-25 14:41:49','916-314-1210','Retha','Felicia',121679773,38,'2/16/2023','Grayhawk','Sacramento','California',94273);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (74,'mcorcut21','PW1rpV','2023-03-02 20:46:05','801-591-1724','Ernaline','Merrile',524671387,749,'3/7/2023','Huxley','Salt Lake City','Utah',84135);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (75,'tguard22','lsPQLK','2022-12-30 07:39:20','505-644-3819','Jasmine','Tilda',825081565,882,'7/2/2022','Buhler','Albuquerque','New Mexico',87105);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (76,'isilly23','H2gCui','2022-06-08 07:44:24','480-325-1890','Corabella','Iorgos',193906354,722,'9/8/2022','Oak Valley','Mesa','Arizona',85215);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (77,'mnewhouse24','9UpzTXIzoBye','2023-02-02 16:25:22','904-127-3282','Douglas','Melodee',400521478,820,'7/29/2022','Emmet','Jacksonville','Florida',32236);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (78,'gvicioso25','JpfPkJd','2022-12-09 10:23:45','310-769-9840','Ora','Geraldine',620020762,212,'7/24/2022','Prairie Rose','Santa Monica','California',90410);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (79,'deveril26','hZUnahUbK9L','2023-02-08 20:33:17','916-187-1418','Sheila-kathryn','Dallis',836641458,349,'7/31/2022','Sherman','Sacramento','California',95833);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (80,'lwinfindale27','x1sr7NuWB73E','2022-09-27 10:13:20','513-641-9501','Shirlene','Lindy',752339569,5,'11/16/2022','Schlimgen','Cincinnati','Ohio',45203);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (81,'ibysh28','mDDujPjZrw','2023-02-02 03:25:28','619-706-8575','Nannie','Ivar',914888836,313,'6/18/2022','Bayside','San Diego','California',92115);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (82,'kpolet29','wyuokwEPWZ5','2023-01-05 04:39:55','352-513-2703','Matthias','Krissie',218626092,835,'1/2/2023','Mallory','Ocala','Florida',34474);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (83,'clangeley2a','MyihWN','2022-05-10 13:20:32','650-142-5493','Virginia','Caroline',230150739,997,'4/3/2023','Lake View','Mountain View','California',94042);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (84,'brain2b','c2IAGO3uzX','2022-04-28 00:22:33','336-864-1812','Thalia','Bard',880622280,754,'7/16/2022','Maple Wood','High Point','North Carolina',27264);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (85,'dtitchen2c','Mq6Xuh03TgDZ','2023-02-05 18:41:17','650-553-0507','Cecilla','Dani',194853309,141,'1/7/2023','John Wall','San Jose','California',95113);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (86,'anatalie2d','e4A9CqR4QlO','2022-06-02 17:53:59','727-544-3612','Rosamund','Alvy',857267896,810,'10/31/2022','Dixon','Saint Petersburg','Florida',33731);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (87,'jgeibel2e','IccrB55bN87s','2022-12-27 12:01:35','239-419-7896','Julee','Julie',585017198,92,'8/19/2022','Ruskin','Naples','Florida',33963);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (88,'dharner2f','t77E0Wxd5z','2022-11-20 10:00:37','214-365-7856','Ingamar','Dani',798001718,212,'12/6/2022','Caliangt','Dallas','Texas',75367);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (89,'hslocombe2g','Ih8heBdd','2023-03-13 21:51:50','857-140-9557','Audry','Hedi',895100708,952,'7/23/2022','Graedel','Watertown','Massachusetts',02472);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (90,'jgimeno2h','xaP9zrn','2022-05-22 10:36:07','304-991-1532','Roxie','Jewelle',958750570,216,'1/11/2023','Mcbride','Huntington','West Virginia',25705);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (91,'dcoombes2i','nb2wyHHwJkv7','2023-02-10 13:20:03','713-564-9315','Roddy','Dorothee',077508023,736,'6/19/2022','Shoshone','Houston','Texas',77015);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (92,'kmacmorland2j','6LeoTb6QM','2022-12-10 10:46:33','520-484-7588','Linda','Krispin',644741911,275,'7/24/2022','Tennessee','Tucson','Arizona',85710);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (93,'nmourant2k','WDJAfn','2022-06-25 23:26:49','806-556-4139','Hermia','Nissie',571269870,399,'4/5/2023','Dayton','Amarillo','Texas',79171);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (94,'rbortoluzzi2l','113vUBVGRr','2022-10-29 04:58:14','828-442-3841','Mitchel','Rosalynd',857351875,528,'2/6/2023','Schlimgen','Asheville','North Carolina',28815);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (95,'pspanswick2m','ONEm44','2023-02-18 17:25:26','701-863-4843','Ann-marie','Patton',981745963,372,'4/7/2023','Anthes','Grand Forks','North Dakota',58207);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (96,'jeastop2n','0f90yE','2022-04-19 15:28:22','305-616-2389','Andrea','Juliet',367429971,66,'2/15/2023','Dryden','Miami','Florida',33169);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (97,'fnunan2o','oWbgIJ7CTh7o','2022-12-01 03:45:35','716-994-6494','Zebulon','Florenza',072836654,117,'7/15/2022','Lerdahl','Buffalo','New York',14233);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (98,'kkarlmann2p','0OdsRtlTyv86','2022-12-09 17:12:32','860-892-5240','Ronna','Klemens',862725386,639,'5/19/2022','Fisk','Hartford','Connecticut',06140);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (99,'psutherley2q','xVWWK1EpOE','2022-05-15 21:44:00','215-515-7513','Hendrick','Paulina',951463873,325,'11/2/2022','Scofield','Philadelphia','Pennsylvania',19125);
INSERT INTO Users(user_id,username,password,date_made,phone_number,first_name,last_name,card_number,cvv,expiration_date,street,city,state,zip_code) VALUES (100,'jfeitosa2r','bf6wDfsCoI','2022-06-19 21:03:42','510-809-5591','Tori','Jordon',974059900,220,'9/24/2022','Columbus','Berkeley','California',94712);

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
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('10', 'rlapishb@nymag.com', '200-935-0539', 'Retha', 'Lapish');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('68', 'gjeunec@springer.com', '229-427-3945', 'Grethel', 'Jeune');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('49', 'smakind@arstechnica.com', '908-708-3264', 'Salomon', 'Makin');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('84', 'fpeirpointe@theatlantic.com', '109-986-2027', 'Frank', 'Peirpoint');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('73', 'tbaintonh@friendfeed.com', '507-314-7405', 'Tobey', 'Bainton');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('2', 'psticklesi@issuu.com', '163-547-0467', 'Patti', 'Stickles');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('33', 'csimeonej@github.com', '929-937-4521', 'Clementina', 'Simeone');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('37', 'soultramk@yale.edu', '570-975-6493', 'Sindee', 'Oultram');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('82', 'jstoadel@bigcartel.com', '561-988-0917', 'Johanna', 'Stoade');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('99', 'rjollandn@sciencedirect.com', '267-862-2844', 'Rickey', 'Jolland');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('80', 'jsemkeno@google.it', '178-865-1635', 'Joly', 'Semken');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('21', 'cduggonq@cdbaby.com', '962-694-1404', 'Camala', 'Duggon');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('1', 'crufflesr@w3.org', '462-766-6663', 'Clerc', 'Ruffles');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('90', 'jwynetts@issuu.com', '826-475-3492', 'Jamesy', 'Wynett');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('96', 'ofennicku@businessinsider.com', '665-952-5282', 'Obed', 'Fennick');
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
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('92', 'cshewry18@ted.com', '336-184-5442', 'Caryl', 'Shewry');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('15', 'epostlewhite19@pbs.org', '425-104-3768', 'Elisha', 'Postlewhite');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('8', 'cpatching1a@wunderground.com', '131-501-4338', 'Chloette', 'Patching');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('38', 'tcraigmile1b@seattletimes.com', '931-657-2248', 'Torey', 'Craigmile');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('64', 'icordeiro1c@fda.gov', '189-195-1621', 'Iris', 'Cordeiro');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('54', 'pmallock1d@homestead.com', '667-480-4801', 'Pen', 'Mallock');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('40', 'rdalessandro1e@guardian.co.uk', '494-654-4747', 'Rhianna', 'Alessandro');
INSERT INTO Administrators (admin_id, email_address, phone_number, first_name, last_name) VALUES ('27', 'ebeeze1g@linkedin.com', '709-424-4876', 'Erskine', 'Beeze');

INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist9e4Mz',5077044,'2022-08-31 13:56:29',425,33,'PlaylistXLKnj',12);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistFup7U',4915047,'2022-09-09 18:47:12',480,89,'PlaylistCk2F1',35);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist6RnSx',8858125,'2022-10-09 07:30:44',154,4,'PlaylistKvYJD',85);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistO7arT',443811,'2022-09-29 21:16:22',251,53,'PlaylistMQpTV',51);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist594TK',933558,'2022-11-12 00:02:22',498,31,'Playlist2KnKT',94);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistTArg1',5219687,'2022-10-18 11:07:24',288,50,'PlaylistA4ohi',17);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist3yCVX',1764615,'2022-08-07 01:13:24',356,73,'Playlist2FvxT',44);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistuWwr2',7006109,'2022-12-26 05:53:36',70,90,'PlaylistteluJ',83);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistStfG3',4824019,'2022-08-17 23:45:45',284,26,'Playlist3pBxf',41);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistSUwe5',7084735,'2023-03-30 04:52:37',93,21,'PlaylistleIAR',71);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist5kwHZ',3225474,'2023-02-13 22:34:00',253,97,'Playlist3w0HE',21);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistLa3eC',7915778,'2022-06-09 14:07:45',377,36,'PlaylistlXOw7',74);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistD1vmc',837103,'2022-12-07 10:28:58',184,100,'Playlist6U7ii',2);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistaAdBt',4427545,'2022-06-14 21:16:29',13,82,'PlaylistfMYsR',55);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistfkZDw',5168396,'2023-04-13 08:48:00',399,33,'Playlist6E2zB',20);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist6PH09',5894457,'2023-02-12 03:13:01',293,48,'PlaylistdaqVj',96);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlists3nuw',6017185,'2022-06-27 12:10:04',193,69,'PlaylistQFTnR',95);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistmrIGV',640855,'2022-11-27 12:39:27',384,45,'PlaylistObUXx',83);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistWloPu',7078483,'2022-04-26 13:57:33',367,73,'PlaylisttFfRg',94);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistxCtdZ',6562245,'2022-10-14 05:22:36',425,81,'PlaylistFuDTd',81);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistQ3Fsz',9890617,'2022-07-18 09:53:15',326,93,'PlaylistripSW',24);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistwOfcm',9431545,'2022-10-11 03:43:15',340,38,'PlaylistDhMMA',56);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistFO6ON',3519367,'2022-06-17 04:23:16',473,92,'Playlist9IxmQ',34);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistMQh1b',37232,'2023-02-13 07:33:59',416,22,'PlaylistexhQP',22);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistmKpKr',9185629,'2022-12-09 19:49:01',221,26,'PlaylistAwyPF',68);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistHdIpw',7361218,'2022-05-20 13:31:05',421,38,'PlaylistWvx7l',82);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistrhXJS',5651181,'2022-06-23 14:12:58',17,82,'Playlist40EKf',37);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlisto42G0',3436801,'2022-04-26 12:43:06',373,66,'PlaylistOOLeq',59);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistMiGtB',9687093,'2022-04-17 01:11:00',197,88,'PlaylistFDyBz',74);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistuSwPb',8563998,'2022-08-16 01:01:44',463,13,'PlaylistGXYvj',17);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistmWrCK',1605332,'2022-09-28 09:57:48',296,41,'Playlistifmfj',69);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistWXdzh',7257771,'2022-12-23 20:25:57',258,56,'PlaylistkfeEv',97);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistCsutE',3949463,'2022-06-01 14:27:54',332,14,'PlaylistHSM0O',1);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistEo9cB',5114200,'2022-11-30 09:22:40',285,58,'PlaylistB1EDC',75);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist5PevY',9271630,'2022-12-28 19:21:59',4,18,'PlaylistlmoIU',35);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlistq3NPA',5505122,'2022-05-21 19:51:50',24,75,'PlaylistvxQ9Y',36);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistluwUL',504377,'2022-11-24 19:08:35',278,52,'PlaylistMqUIy',1);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistbS7QM',8227655,'2022-04-25 00:50:51',381,82,'PlaylistjacQT',70);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistKGo7H',5576101,'2022-06-05 08:02:02',176,45,'PlaylistkAt89',72);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistGUyVO',4174354,'2022-08-07 18:40:21',19,20,'PlaylistOyjYJ',22);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistBpmGi',7428489,'2022-12-22 03:44:51',476,27,'Playlist1zBg9',2);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistpTONE',1361332,'2022-12-06 04:20:40',308,96,'PlaylistvACsf',18);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistNNsKO',4459043,'2022-10-31 05:24:01',249,6,'PlaylistDsYNo',36);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistJS37i',6477819,'2023-01-25 21:18:03',402,99,'PlaylistbgmY9',94);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistRQX33',6603941,'2022-04-30 04:01:44',250,84,'Playlist5SO7w',87);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistonNNW',6582996,'2022-11-02 13:07:28',469,47,'PlaylistiMBgg',63);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistddrWx',558718,'2023-01-13 22:57:38',262,80,'PlaylistPGvVP',99);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistWHnpM',6534974,'2022-05-15 06:22:19',499,36,'PlaylistXt9CI',44);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistjmrSG',218250,'2022-12-03 10:13:22',37,64,'Playlistq80mB',50);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlistm3GaY',6506723,'2023-02-02 10:34:51',450,19,'PlaylistFnuyT',72);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlistg30Wn',3962021,'2022-08-18 12:59:30',89,42,'PlaylistaXnLX',58);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistZ77A8',8439569,'2022-09-17 12:47:19',124,15,'PlaylistWkJi8',93);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylisthJaX2',6137150,'2022-07-12 22:12:48',408,48,'Playlistm9mmS',17);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistUWxdk',3404619,'2022-06-18 23:51:39',107,55,'PlaylistdELu1',90);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistKcXK5',1356329,'2023-04-09 21:01:50',329,1,'PlaylistrRqXt',1);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistrCd9W',9259619,'2022-04-24 08:10:52',434,27,'PlaylistEQju4',90);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlistq5CEe',9842716,'2022-07-15 22:44:38',335,23,'Playlist4tN8F',99);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistoZFHL',3220988,'2022-08-11 20:59:39',34,11,'PlaylistAS0oJ',2);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistydcYY',9980797,'2023-01-27 02:52:33',363,48,'Playlist5eD8O',31);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistKcStP',3727700,'2022-12-11 19:19:58',2,76,'Playlists1gER',98);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistogPOQ',5442189,'2022-11-24 11:30:47',294,59,'Playlist9Xbm3',22);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistTOcRr',2105021,'2022-09-14 07:27:03',372,43,'Playlisthp0Bc',73);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistXaYdE',3485963,'2022-05-13 18:03:23',29,73,'PlaylistPTOO1',21);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistvXwcp',1618372,'2022-07-22 22:32:01',162,85,'PlaylistxEzUH',8);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistW4cnK',4344026,'2023-01-11 06:50:23',498,90,'Playlistgk8Kd',54);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistY4Bba',2901353,'2023-03-11 06:49:05',231,57,'PlaylistkeQQC',23);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlistugfzy',1776423,'2023-03-03 23:01:06',242,64,'PlaylistiLtIL',5);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist00NNC',7234567,'2022-07-12 22:08:46',395,66,'PlaylistdyMw7',19);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistDFLRR',2780002,'2022-04-28 09:19:47',362,47,'Playlist1i1ew',87);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistJiM30',8990544,'2023-02-20 11:08:44',343,74,'PlaylistKOYKR',56);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistWaAow',2174350,'2022-10-05 02:28:15',95,94,'Playlist9JPNG',8);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistjtWL7',199271,'2022-11-02 17:12:10',189,78,'PlaylistR8Llh',72);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistSHSpz',8825652,'2022-08-11 02:35:50',7,91,'PlaylistCMvFT',18);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistWGcsr',4121673,'2022-07-27 17:45:43',256,46,'PlaylistX9OwD',95);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistvBwrX',1705271,'2022-11-01 18:57:38',287,47,'PlaylisthfNQ5',23);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist4hFin',7597115,'2022-06-26 07:15:08',408,53,'PlaylistaDrbK',54);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistNwFey',7184433,'2022-11-16 13:30:22',69,1,'PlaylistabNYg',35);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistMw4Hw',1625354,'2022-12-23 13:50:25',362,10,'Playlistmk0d1',83);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistVU0q3',6845463,'2023-03-29 06:39:16',486,12,'PlaylistG51kC',39);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistzO4fg',6692782,'2022-11-09 13:31:22',200,8,'PlaylistZmSgC',33);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistPnJPh',3640823,'2023-04-07 02:26:13',211,20,'Playlistmybti',12);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistCu1bc',1970129,'2023-02-05 13:08:41',54,48,'PlaylistwoBmu',93);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistvDR8O',7118027,'2022-08-16 05:01:24',153,5,'PlaylistbXkIX',21);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistpW9lb',6877176,'2023-04-08 03:14:12',398,9,'PlaylistodI8J',70);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistCCrJW',4059236,'2022-12-01 06:38:42',14,96,'PlaylistYx3xe',85);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistGrGfq',2244549,'2023-04-03 15:37:28',440,50,'Playlist7th6j',53);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistDI0Bm',2199100,'2023-01-12 09:22:07',102,44,'PlaylistWJnrH',57);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylisttSC2T',990324,'2022-05-26 18:15:49',295,15,'PlaylistWWn2I',1);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistJ9hOl',4737359,'2022-06-04 18:15:15',339,98,'Playlist8hrCU',31);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlist33nhN',8982078,'2022-06-24 16:29:40',66,21,'PlaylistmzJpx',48);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('Playlistl5SDT',5999284,'2022-06-05 13:00:11',339,75,'Playlist3KbYV',5);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistANcTu',8909301,'2022-08-16 00:18:12',498,25,'Playlistpzz18',37);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistHBzMh',6701547,'2022-04-21 15:38:10',27,82,'Playlistqj3gK',21);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistWziNB',744492,'2022-08-21 04:02:32',297,26,'PlaylistLk6vk',75);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistJO2uB',3775985,'2023-03-05 19:13:30',442,78,'Playlist6LX6E',76);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistWPkkK',6871612,'2022-12-15 19:09:34',59,66,'PlaylisttfcgL',71);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistcoJTi',653859,'2022-04-17 15:18:11',111,70,'Playlist8lrBj',57);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistDTnBE',8415468,'2022-07-02 11:37:21',3,8,'Playlistac8GQ',53);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistDVJHK',7186768,'2022-04-16 10:16:27',370,67,'PlaylistazaRg',10);
INSERT INTO Playlists(name,likes,date_made,duration,episode_number,playlist_name,user_id) VALUES ('PlaylistHJfHE',6930391,'2022-11-22 15:52:27',390,29,'PlaylistUHiVl',93);

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
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('76', '8674455', '9745580', '1461914', '2013924');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('11', '8261622', '1859635', '2836459', '5153198');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('64', '5853432', '3666909', '3973467', '8217319');
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
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('88', '2010011', '8915364', '4590555', '1543916');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('82', '2444550', '4569388', '3777547', '6942082');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('62', '5296524', '6220436', '4836249', '6899771');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('55', '3163260', '5426762', '5103648', '3350043');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('90', '4518627', '5269611', '5113946', '9387993');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('83', '6241875', '9935675', '786845', '6461318');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('86', '6289598', '4105521', '9630145', '1663737');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('7', '6405165', '2190692', '2145112', '8012167');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('80', '2907189', '5262259', '3740775', '9591209');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('69', '1940850', '192597', '4199071', '1634860');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('93', '9600396', '3878021', '3296698', '7787091');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('36', '4747372', '6198862', '2293105', '1466087');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('89', '4549427', '9668040', '9537618', '9085580');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('13', '7100344', '8486782', '1746929', '5129121');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('94', '8815112', '6941032', '4711649', '8967398');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('35', '6804798', '1925378', '7452938', '2594032');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('73', '4906314', '9538931', '9293155', '6125570');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('24', '5806222', '8865685', '6554985', '9619978');
INSERT INTO Statistics (creator_id, total_listens, total_likes, total_followers, total_episodes) VALUES ('77', '6168172', '587550', '1484524', '5885226');

INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (1,38,'Burrows','Apache Junction','Arizona',85219);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (2,49,'Fulton','Lake Worth','Florida',33467);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (3,80,'Crest Line','Jacksonville','Florida',32209);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (4,79,'Vahlen','Detroit','Michigan',48275);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (5,1,'Nelson','Charlotte','North Carolina',28235);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (6,82,'Bay','Rochester','Minnesota',55905);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (7,14,'Artisan','Washington','District of Columbia',20436);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (8,93,'Lakeland','Lancaster','Pennsylvania',17622);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (9,39,'Washington','Birmingham','Alabama',35210);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (10,9,'Fallview','Phoenix','Arizona',85077);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (11,51,'Meadow Ridge','Fort Worth','Texas',76192);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (12,29,'Karstens','Cheyenne','Wyoming',82007);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (13,37,'Chive','Kansas City','Missouri',64114);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (14,15,'Shopko','Knoxville','Tennessee',37931);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (15,20,'Del Mar','Tampa','Florida',33673);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (16,26,'Bluestem','Saint Louis','Missouri',63158);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (17,81,'Kipling','Cincinnati','Ohio',45218);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (18,31,'Kropf','San Antonio','Texas',78245);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (19,27,'Troy','Dallas','Texas',75236);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (20,10,'Springs','Palm Bay','Florida',32909);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (21,94,'Kenwood','Migrate','Kentucky',41905);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (22,16,'Hintze','Columbus','Ohio',43284);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (23,26,'Lakeland','Anaheim','California',92825);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (24,45,'Golden Leaf','Fairbanks','Alaska',99790);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (25,85,'Norway Maple','Des Moines','Iowa',50362);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (26,20,'Chive','Rochester','New York',14624);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (27,66,'Myrtle','Dallas','Texas',75246);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (28,3,'Surrey','El Paso','Texas',79984);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (29,12,'Dwight','White Plains','New York',10633);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (30,22,'Mallory','Harrisburg','Pennsylvania',17110);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (31,44,'Loomis','Atlanta','Georgia',31119);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (32,49,'Alpine','Las Vegas','Nevada',89166);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (33,1,'Kim','San Antonio','Texas',78291);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (34,8,'Beilfuss','Juneau','Alaska',99812);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (35,13,'Fuller','Boise','Idaho',83757);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (36,81,'Heffernan','Saint Louis','Missouri',63143);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (37,84,'Harper','Jackson','Tennessee',38308);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (38,3,'Susan','New York City','New York',10090);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (39,36,'Debra','Houston','Texas',77228);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (40,99,'Saint Paul','Laurel','Maryland',20709);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (41,94,'Moulton','Plano','Texas',75074);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (42,78,'Stoughton','Memphis','Tennessee',38104);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (43,99,'Upham','Racine','Wisconsin',53405);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (44,100,'Mallory','Palatine','Illinois',60078);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (45,21,'Sloan','Terre Haute','Indiana',47812);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (46,48,'Merrick','Los Angeles','California',90005);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (47,92,'Marcy','New York City','New York',10079);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (48,61,'Dovetail','Brooklyn','New York',11205);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (49,11,'Johnson','Pittsburgh','Pennsylvania',15210);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (50,14,'Warner','Pasadena','California',91109);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (51,77,'Havey','Houston','Texas',77288);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (52,97,'John Wall','Evansville','Indiana',47719);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (53,58,'Red Cloud','Chico','California',95973);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (54,70,'Muir','Hartford','Connecticut',06183);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (55,80,'Bowman','Bradenton','Florida',34210);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (56,9,'Brown','Richmond','Virginia',23242);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (57,77,'International','Nashville','Tennessee',37215);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (58,54,'Forest Dale','Pasadena','Texas',77505);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (59,78,'Clarendon','Cincinnati','Ohio',45223);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (60,42,'Morningstar','Norman','Oklahoma',73071);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (61,37,'Mockingbird','Chicago','Illinois',60614);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (62,35,'Fallview','Saint Louis','Missouri',63169);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (63,59,'Dapin','Springfield','Illinois',62711);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (64,52,'Lakewood','Columbus','Ohio',43215);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (65,15,'Kinsman','Rochester','New York',14639);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (66,8,'Evergreen','Huntington','West Virginia',25775);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (67,2,'Bayside','Northridge','California',91328);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (68,51,'Autumn Leaf','Austin','Texas',78737);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (69,21,'Toban','San Jose','California',95123);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (70,6,'Cody','Boise','Idaho',83716);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (71,52,'Kropf','Scranton','Pennsylvania',18505);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (72,90,'Nancy','Topeka','Kansas',66699);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (73,85,'Texas','Reading','Pennsylvania',19605);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (74,46,'Golf','Columbia','South Carolina',29240);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (75,100,'Monument','Baltimore','Maryland',21265);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (76,17,'3rd','Oklahoma City','Oklahoma',73167);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (77,26,'Johnson','New York City','New York',10034);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (78,97,'Golf Course','Springfield','Illinois',62776);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (79,25,'Anniversary','Birmingham','Alabama',35220);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (80,42,'Bayside','Roanoke','Virginia',24034);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (81,54,'Onsgard','Montpelier','Vermont',05609);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (82,2,'Moland','Lincoln','Nebraska',68505);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (83,5,'Glacier Hill','Mesa','Arizona',85205);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (84,95,'Northwestern','Akron','Ohio',44310);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (85,80,'Spaight','Houston','Texas',77065);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (86,27,'Manley','San Francisco','California',94147);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (87,56,'Boyd','Washington','District of Columbia',20535);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (88,61,'Fuller','Fort Lauderdale','Florida',33336);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (89,67,'Anniversary','Detroit','Michigan',48217);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (90,17,'Sutteridge','Champaign','Illinois',61825);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (91,85,'Northland','Monroe','Louisiana',71213);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (92,75,'Eagle Crest','Buffalo','New York',14269);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (93,70,'Carey','Lincoln','Nebraska',68505);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (94,98,'Kinsman','Dayton','Ohio',45408);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (95,14,'Kipling','Buffalo','New York',14210);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (96,23,'Melody','Albuquerque','New Mexico',87201);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (97,66,'Mesta','Saint Louis','Missouri',63126);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (98,83,'Ridge Oak','Peoria','Illinois',61656);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (99,16,'Portage','Houston','Texas',77030);
INSERT INTO Suppliers(supplier_id,item_number,street,city,state,zip_code) VALUES (100,24,'Sunnyside','Gatesville','Texas',76598);

INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8286007,53,'L','2023-06-27 22:51:15','2022-11-14 11:44:55');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (7324910,70,'XS','2022-04-20 07:43:14','2022-08-24 03:10:55');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3195346,2,'M','2022-03-14 13:25:59','2022-06-07 07:19:43');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1499358,45,'L','2022-09-26 13:31:32','2022-03-12 00:31:38');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4174049,13,'L','2022-12-26 23:42:02','2023-02-12 07:41:47');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8146768,60,'XS','2022-10-01 20:10:11','2022-10-31 13:42:46');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (2561045,41,'3XL','2022-09-16 14:52:30','2022-04-24 02:27:28');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8225365,65,'M','2023-03-08 01:40:41','2023-04-12 13:23:42');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1180113,7,'XS','2023-04-26 19:36:25','2022-06-22 14:42:50');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3126769,20,'M','2022-12-27 09:46:04','2022-08-08 20:54:21');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3939093,79,'2XL','2023-07-07 00:24:58','2022-05-12 12:17:17');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (5529234,88,'XL','2023-03-15 21:17:36','2022-12-13 11:00:30');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6546594,11,'3XL','2022-06-12 14:42:49','2022-09-20 14:24:39');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9628977,28,'L','2023-04-14 00:44:01','2022-06-13 17:20:49');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1458581,98,'XS','2023-07-26 03:24:27','2023-03-19 16:49:24');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6498100,55,'L','2023-05-13 21:47:09','2022-04-10 06:57:06');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3254233,4,'S','2023-06-28 23:00:02','2022-04-23 00:11:01');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (22972,85,'3XL','2023-06-24 15:23:39','2023-07-28 14:49:07');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (7462694,11,'S','2023-06-15 06:44:29','2022-04-20 04:59:05');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3359300,57,'XL','2022-10-20 22:38:01','2022-04-09 22:20:37');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (7561164,88,'3XL','2022-06-12 06:32:04','2022-03-08 16:44:15');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8247354,78,'2XL','2022-06-15 19:02:56','2023-03-18 04:39:54');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9284877,57,'XS','2022-11-06 06:21:57','2022-09-17 09:23:24');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (84739,29,'2XL','2022-04-29 08:42:31','2022-05-05 04:59:42');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (5038642,37,'3XL','2022-11-10 23:41:39','2022-09-08 02:00:30');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (385628,33,'M','2022-05-15 18:47:23','2022-04-22 20:54:51');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (272220,33,'S','2022-08-06 02:05:43','2022-09-10 22:30:54');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3331165,94,'3XL','2023-02-04 19:11:48','2023-04-11 00:13:27');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3054366,64,'2XL','2022-04-24 15:01:41','2022-08-10 03:14:33');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8076173,56,'3XL','2022-10-23 05:16:47','2022-06-18 16:33:56');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6846686,94,'2XL','2022-08-24 05:32:30','2023-01-17 08:26:12');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8180350,94,'M','2022-04-14 07:50:30','2022-06-14 20:06:24');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (7776955,7,'M','2022-03-09 13:32:21','2023-05-25 16:46:52');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6364429,47,'L','2022-07-31 17:11:18','2022-07-20 13:46:46');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1021082,58,'L','2023-01-15 22:22:50','2022-06-03 08:33:47');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (7609487,11,'2XL','2023-03-12 14:28:56','2022-09-13 09:53:17');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6539965,91,'2XL','2023-06-10 00:01:12','2022-06-21 15:48:17');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (2420312,55,'L','2023-07-16 18:59:47','2023-07-10 02:14:21');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9557581,12,'L','2022-12-04 12:43:55','2023-01-13 16:21:22');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (762943,18,'L','2022-12-10 14:06:58','2022-10-17 16:18:03');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3446358,17,'XL','2023-06-26 05:32:25','2023-03-28 16:38:33');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8095758,51,'XS','2022-06-11 03:26:12','2022-05-27 09:18:35');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (2098229,61,'XS','2023-06-04 21:20:05','2022-07-25 21:55:08');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1374648,14,'3XL','2022-11-30 01:36:39','2022-10-08 10:03:31');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9259670,60,'S','2023-06-02 05:42:26','2022-04-02 01:12:20');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8765938,78,'L','2023-06-05 20:53:48','2023-03-15 06:04:22');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (5879982,31,'3XL','2022-09-12 17:28:28','2022-06-18 02:00:02');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9862133,89,'XL','2023-02-07 04:08:50','2022-09-17 04:23:45');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4663239,16,'M','2023-04-21 03:49:09','2022-11-29 08:11:41');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4191978,8,'XL','2022-08-27 06:30:53','2023-04-04 12:44:14');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1558079,96,'2XL','2022-11-11 22:55:07','2022-11-07 06:19:26');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6795990,39,'XS','2022-07-16 13:55:53','2023-06-24 04:40:04');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9006731,60,'S','2022-11-04 21:16:42','2022-05-10 13:40:18');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4249393,20,'S','2022-06-28 12:36:31','2022-06-18 19:09:05');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4974134,86,'3XL','2022-10-04 10:37:25','2023-07-21 17:21:33');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6796970,48,'2XL','2023-05-07 03:36:35','2022-10-31 04:21:08');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (7029195,73,'3XL','2022-07-26 22:56:29','2023-01-26 09:42:43');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1014862,73,'M','2023-04-25 09:45:21','2022-11-01 09:46:36');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9443645,3,'M','2023-06-10 20:58:53','2023-04-11 17:35:56');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9947565,8,'3XL','2023-06-28 12:15:50','2022-09-09 08:04:46');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9044612,100,'M','2022-03-12 02:04:14','2022-09-10 12:18:27');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (224849,77,'S','2022-12-22 17:09:26','2022-10-06 10:54:02');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (2352236,54,'XL','2022-06-04 11:19:34','2022-06-22 05:55:48');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1836642,53,'3XL','2023-06-24 11:04:49','2022-04-09 23:17:53');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3846828,8,'S','2022-04-11 11:33:57','2023-07-17 18:16:01');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9524571,76,'XL','2022-11-25 16:50:53','2023-02-26 23:47:56');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4414666,74,'XL','2022-03-15 06:55:28','2023-01-06 14:19:29');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8377631,58,'XL','2022-09-28 02:01:05','2022-04-03 14:59:37');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (954312,22,'L','2022-12-10 20:52:46','2022-04-26 04:39:31');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8444617,85,'3XL','2022-03-08 14:55:12','2023-03-13 19:34:40');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (7124955,42,'3XL','2022-03-02 00:19:11','2022-11-30 06:19:46');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8505749,31,'3XL','2022-10-28 20:56:41','2022-11-23 02:47:58');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (7545137,8,'L','2023-06-09 00:46:54','2023-01-27 04:36:51');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8877730,34,'M','2023-01-13 02:54:45','2023-01-07 14:46:32');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (69514,87,'3XL','2022-09-16 11:11:04','2023-02-01 03:48:37');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6539695,74,'XS','2023-01-27 00:21:18','2022-03-06 22:43:24');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1325632,58,'XL','2022-12-01 05:57:23','2023-02-11 19:55:41');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (6104366,1,'XL','2022-07-28 08:54:46','2022-11-17 15:08:47');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9120370,13,'M','2023-07-15 16:32:29','2022-10-04 19:21:49');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (2506393,23,'M','2022-03-19 18:00:56','2023-06-22 16:10:02');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1965667,8,'L','2023-01-18 23:52:16','2023-04-06 16:08:44');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9647872,83,'2XL','2022-03-16 09:59:55','2023-07-15 20:03:51');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8606939,91,'L','2023-01-21 05:50:12','2023-01-18 14:18:56');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (3910185,59,'XS','2023-04-12 07:59:28','2022-05-16 03:40:05');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (8215552,37,'XS','2022-11-21 07:52:20','2023-02-07 07:46:23');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9226667,18,'XL','2023-04-30 03:23:29','2023-05-15 00:35:03');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (5756704,8,'2XL','2022-10-20 18:22:04','2022-11-23 06:57:22');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (5092648,66,'3XL','2022-07-26 23:17:33','2022-03-23 00:02:51');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1695405,50,'XL','2022-03-26 02:04:34','2023-01-10 03:33:28');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (9339508,15,'XL','2023-03-16 15:55:39','2023-02-19 18:34:58');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (2107448,19,'2XL','2023-07-21 02:07:44','2023-02-10 07:19:11');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (967044,54,'2XL','2022-12-07 01:56:26','2022-12-30 10:02:02');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1605137,43,'S','2023-01-13 09:50:01','2023-06-04 13:24:13');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4649689,78,'M','2023-06-26 18:38:44','2022-11-12 03:56:10');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4179048,76,'S','2022-06-23 15:30:17','2023-05-21 07:28:40');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (4917285,96,'3XL','2022-04-19 06:14:43','2022-12-04 04:58:42');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (2373278,55,'S','2022-05-02 05:12:49','2022-10-06 17:26:24');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (1387112,23,'L','2022-09-13 23:41:33','2023-02-19 17:01:39');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (785191,84,'M','2022-08-18 09:21:57','2022-12-11 20:08:22');
INSERT INTO Inventory(total_in_stock,item_number,available_sizes,date_last_restock,date_next_restock) VALUES (2447448,45,'2XL','2022-09-02 10:20:58','2022-06-05 08:37:26');

INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (1,'Xavdpywubsxnfp','L','2023-02-20 20:12:12','2022-07-16 17:14:27','Florida','West','Pensacola',32575,71,24,8076173);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (2,'Uepxccyiurdiwa','S','2023-01-03 20:23:44','2023-03-16 21:58:01','Virginia','Upham','Richmond',23203,73,88,9862133);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (3,'Ugqkyanjnuqktm','3XL','2023-02-05 11:39:42','2022-12-11 03:28:56','New York','Warbler','Buffalo',14269,50,3,8247354);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (4,'Qyidfpkawhusxr','L','2022-10-20 02:11:41','2022-12-21 04:33:46','Ohio','Kings','Toledo',43699,62,60,6795990);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (5,'Fdboefimvrddsw','2XL','2022-05-03 23:14:23','2023-01-13 20:41:45','California','Mallory','Oakland',94622,70,17,4249393);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (6,'Actugxjyizrruq','2XL','2022-11-28 16:57:07','2022-12-07 02:03:48','Illinois','Walton','Springfield',62711,30,86,762943);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (7,'Tcvrgeddgesysg','XS','2022-10-07 07:20:04','2023-01-03 15:18:57','Massachusetts','Commercial','Boston',02283,60,89,9524571);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (8,'Gkktamidrennbz','M','2023-03-10 16:19:22','2022-10-10 23:15:18','District of Columbia','Green','Washington',20268,12,23,8247354);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (9,'Hpsvehlpphggrs','3XL','2022-07-20 00:52:38','2022-05-21 05:11:40','Florida','Lakewood','Tampa',33686,99,36,6846686);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (10,'Zpjnrjzgwowduj','L','2022-09-19 16:40:48','2022-06-17 18:05:58','New York','Crownhardt','Utica',13505,34,2,8225365);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (11,'Lcxnyydrfxtnkg','XL','2022-07-29 02:42:36','2022-12-08 00:54:12','Illinois','Oakridge','Bloomington',61709,9,58,4974134);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (12,'Oquzmbufifgmwm','XS','2023-02-01 14:21:20','2022-05-17 17:25:05','Louisiana','Thackeray','Alexandria',71307,57,20,1325632);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (13,'Ybneotnrvwqwfi','S','2022-12-14 15:52:41','2023-01-03 10:29:18','Washington','Vernon','Seattle',98109,76,4,4917285);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (14,'Khwrehjandbmkl','L','2023-04-13 19:02:02','2023-01-06 19:26:14','Florida','Killdeer','Tallahassee',32304,5,96,7545137);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (15,'Cveqouclbmhmtf','L','2023-04-05 02:08:19','2022-05-09 10:22:39','Mississippi','Basil','Jackson',39236,39,64,4174049);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (16,'Eahowpulzumopv','XL','2023-02-24 03:01:21','2023-01-13 14:24:26','Florida','Kinsman','Orlando',32868,14,15,5879982);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (17,'Wohuwyyozieikm','L','2022-09-30 02:31:50','2022-11-01 07:23:31','California','Meadow Ridge','Van Nuys',91499,67,72,6796970);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (18,'Cyyhnrjkuwjqlx','S','2023-03-22 22:20:41','2022-06-18 02:08:44','Texas','Calypso','Houston',77065,78,68,3254233);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (19,'Rkocjcsyrbclef','XS','2023-02-22 19:18:58','2022-11-01 19:59:58','Indiana','Towne','Muncie',47306,11,90,6846686);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (20,'Lrzjzysjvlfrvc','XL','2022-09-09 04:20:48','2022-08-01 17:07:36','Texas','Golf','Houston',77095,35,4,7561164);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (21,'Izumxbznqexatu','L','2022-10-14 00:58:10','2022-06-06 08:13:34','West Virginia','Crescent Oaks','Morgantown',26505,73,47,7609487);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (22,'Zzfwpgawobfqxa','XS','2023-03-07 03:03:53','2022-05-11 18:07:48','New York','Village Green','Brooklyn',11210,86,85,8076173);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (23,'Xwjvnowmffrpwe','3XL','2022-05-12 07:59:38','2023-01-24 20:55:50','Connecticut','Dexter','Bridgeport',06606,51,65,8606939);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (24,'Ejwjwtemvegyxk','L','2023-01-08 15:08:21','2022-04-21 05:26:25','North Carolina','Crownhardt','Wilmington',28410,97,22,9524571);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (25,'Lhnlvwbeqqvrhn','3XL','2022-12-22 07:31:05','2023-03-18 17:23:10','Texas','Debra','Longview',75605,49,48,7324910);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (26,'Wprpbbnhryblxf','S','2022-06-17 07:03:35','2023-02-05 15:06:38','California','Monica','San Jose',95194,21,62,6104366);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (27,'Pbidhlnfqgzkro','XL','2023-02-21 02:10:01','2022-10-12 12:29:40','Florida','Melody','Orlando',32803,33,17,7776955);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (28,'Kqaqyeibwuoyqh','2XL','2023-01-01 16:46:26','2023-01-04 20:07:36','Georgia','3rd','Athens',30605,28,35,1965667);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (29,'Znglnnhervmxvu','XL','2022-05-15 15:33:42','2022-05-11 01:27:25','Florida','Columbus','Pensacola',32590,59,47,8505749);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (30,'Svszonetjmvndi','2XL','2023-02-18 16:20:33','2022-10-14 20:08:11','Texas','Darwin','Houston',77245,93,76,2373278);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (31,'Zextjelhgwfrfr','L','2022-04-20 18:16:07','2023-04-08 16:58:57','Texas','Forest','Garland',75049,35,29,2373278);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (32,'Pmxrcgzljanikf','M','2022-09-16 21:38:05','2022-05-19 19:25:33','Texas','Mosinee','Dallas',75310,61,2,3195346);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (33,'Nbwdnivwhxzxqo','S','2023-01-19 22:12:00','2023-02-23 06:13:45','Texas','Calypso','El Paso',79905,56,83,8215552);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (34,'Sqrruodurssmsf','XS','2022-07-09 08:40:56','2022-08-07 10:03:17','District of Columbia','Ohio','Washington',20299,40,25,7561164);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (35,'Qbpxktxdlgqfhr','M','2023-02-20 20:45:05','2023-02-28 12:15:50','New York','Bultman','New York City',10090,30,35,4663239);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (36,'Uvpvrddmkmtfic','L','2022-12-18 04:37:32','2023-04-07 04:56:51','District of Columbia','Dryden','Washington',20508,43,75,6498100);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (37,'Vzykaeuljbkeur','3XL','2022-06-09 09:49:19','2022-11-09 20:45:05','Texas','Valley Edge','Dallas',75310,81,40,3846828);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (38,'Zkzcsbaorjsxie','L','2023-04-01 21:18:02','2023-02-04 14:43:09','Mississippi','Rowland','Jackson',39216,92,9,7124955);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (39,'Mrephvkovcdpun','M','2022-05-11 00:26:13','2022-06-03 03:26:01','Florida','Schurz','Hialeah',33018,48,93,8076173);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (40,'Gdldtxwmbutksm','3XL','2022-10-12 03:00:48','2023-03-23 08:05:09','California','High Crossing','Bakersfield',93311,91,72,1836642);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (41,'Qallcckkzxccrp','S','2022-05-17 14:25:04','2022-10-17 14:24:41','California','Daystar','Concord',94522,34,31,4191978);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (42,'Rplnvkxonsmnsv','L','2022-09-26 04:44:34','2022-06-05 17:01:21','Delaware','Russell','Wilmington',19810,71,41,8095758);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (43,'Ctummbxvrkukof','M','2022-07-14 02:28:45','2023-03-22 05:44:12','Texas','Riverside','Abilene',79699,38,6,2373278);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (44,'Sflgedeoznxvyx','XL','2023-03-28 03:43:42','2022-05-12 05:48:42','Florida','Florence','Jacksonville',32215,13,22,2561045);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (45,'Tnvwpiwggqusxm','3XL','2022-05-12 07:11:37','2023-01-20 20:46:19','North Carolina','Anderson','Charlotte',28205,49,97,7609487);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (46,'Oabmyncwtgrree','3XL','2023-01-26 22:17:20','2022-12-21 13:38:13','Texas','Stephen','Dallas',75379,42,74,967044);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (47,'Guzhsrbiiaqkzu','3XL','2022-04-16 04:56:19','2022-04-23 22:23:12','Florida','Quincy','Winter Haven',33884,6,35,9006731);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (48,'Ddxlxxwjqrxlgx','3XL','2022-10-25 02:28:56','2022-12-06 09:55:37','Florida','Veith','Naples',34102,80,15,6796970);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (49,'Uiywvlpgsagxor','XS','2022-06-19 08:28:49','2023-02-08 16:08:10','South Carolina','Tomscot','Columbia',29203,70,21,3126769);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (50,'Ybjthgczdvdcgj','XS','2022-08-19 18:41:44','2022-11-21 16:30:43','Minnesota','Clove','Saint Paul',55172,99,36,1014862);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (51,'Eplqnalifedbyu','XS','2023-02-12 19:39:56','2022-07-27 16:25:35','Washington','Longview','Spokane',99220,37,92,6104366);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (52,'Dqtcejhhxcbtoi','XL','2022-07-02 02:07:52','2023-01-01 00:58:35','Missouri','Fieldstone','Saint Louis',63143,85,57,9443645);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (53,'Qmzwyahjhkecxe','XS','2022-05-13 03:12:14','2023-04-11 06:39:28','Texas','Thierer','San Antonio',78215,24,65,9647872);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (54,'Zmalqmbyyzajfc','XL','2022-08-25 02:18:23','2022-12-27 01:17:49','Virginia','Rutledge','Sterling',20167,64,88,8225365);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (55,'Bdtkkvthkaadbx','L','2022-08-22 07:35:30','2023-02-12 14:25:54','Nevada','Mitchell','Las Vegas',89155,55,19,8877730);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (56,'Exprbgabsbdxsm','3XL','2022-04-28 17:25:26','2022-04-24 18:36:55','New York','Glacier Hill','White Plains',10633,41,88,4414666);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (57,'Dufzenpzhnwszf','XS','2022-09-17 23:55:06','2023-04-10 22:18:01','Maryland','Morrow','Rockville',20851,44,58,8095758);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (58,'Beqamsapcdjixc','L','2022-08-27 16:19:37','2023-04-15 21:00:10','Ohio','Dixon','Dayton',45432,23,45,7324910);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (59,'Qivimidlhrwkzl','S','2022-11-19 04:47:59','2023-04-12 13:19:57','New York','Kim','Jamaica',11447,37,91,2373278);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (60,'Cvsqrixfvlcmao','L','2022-09-21 15:38:34','2023-03-03 16:37:18','Illinois','West','East Saint Louis',62205,87,70,1387112);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (61,'Tmhzvhkmkprnry','XL','2022-04-20 02:21:11','2022-09-22 04:03:33','District of Columbia','Eliot','Washington',20210,66,42,1387112);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (62,'Dhgyljdzpukvfh','M','2022-11-24 09:26:56','2022-06-17 21:52:24','Virginia','Fairview','Fredericksburg',22405,48,96,7029195);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (63,'Znftnrxqkgkvyj','2XL','2022-11-06 13:20:14','2022-05-09 06:46:58','California','Westridge','Pasadena',91131,61,84,2420312);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (64,'Yzleifzhzusscl','2XL','2022-12-22 09:53:00','2022-10-25 04:28:40','Arizona','Mariners Cove','Phoenix',85015,58,10,5529234);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (65,'Wixjilfhlqjymz','2XL','2022-11-08 23:56:42','2022-09-01 08:52:13','California','La Follette','Riverside',92505,5,67,9044612);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (66,'Vcbkhjfrkaanth','M','2022-09-12 11:32:32','2023-02-24 10:57:41','Massachusetts','Sloan','Waltham',02453,51,19,4414666);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (67,'Yejwzvcxilbjbp','3XL','2022-09-15 10:05:21','2022-10-23 17:03:39','Mississippi','Dakota','Hattiesburg',39404,56,29,8076173);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (68,'Daftgaxjovbvef','2XL','2023-01-13 16:56:56','2023-04-05 04:53:49','Texas','La Follette','Dallas',75310,34,91,1374648);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (69,'Kappdlqzgsfnoy','L','2023-01-03 09:20:52','2022-07-04 11:33:19','Maryland','Wayridge','Gaithersburg',20883,86,71,2098229);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (70,'Lcaqvolgoyvato','M','2022-10-23 16:29:45','2022-05-04 08:16:21','Texas','Onsgard','El Paso',88574,94,9,7124955);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (71,'Ejohynfxqiprjn','XS','2022-06-15 21:51:17','2023-03-04 01:15:47','Texas','Blackbird','Austin',78710,81,40,6539965);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (72,'Noztbeaxqjcvyx','L','2022-12-29 17:47:00','2022-08-18 04:41:52','California','Tomscot','San Francisco',94147,7,43,4649689);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (73,'Yvzcktowdmtbyi','XS','2022-08-18 02:39:11','2022-06-19 03:52:03','Georgia','Anzinger','Savannah',31405,21,9,8377631);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (74,'Fwrnbnnagogmqg','2XL','2022-09-19 09:49:15','2022-08-10 14:06:14','Washington','Dixon','Tacoma',98442,53,73,9044612);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (75,'Hlauowthwhdqsy','2XL','2022-10-17 14:39:44','2022-05-02 09:43:49','Missouri','Anthes','Saint Louis',63131,17,5,6364429);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (76,'Evipekueikrsko','XS','2023-01-11 20:31:26','2022-08-23 17:49:32','Georgia','Prentice','Norcross',30092,31,25,967044);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (77,'Mfikxxrnoacwra','2XL','2023-01-24 04:15:27','2022-05-07 06:12:20','California','Trailsway','Los Angeles',90189,79,57,5038642);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (78,'Dvbczmpocpvdue','XS','2022-12-07 04:18:57','2022-06-11 18:25:16','Georgia','Sloan','Columbus',31914,57,94,8215552);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (79,'Khqxbsnjgwcrod','XS','2022-08-26 11:25:22','2023-01-07 06:10:43','Louisiana','Brickson Park','New Orleans',70116,95,40,3054366);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (80,'Qjfypnreonfihy','2XL','2023-02-07 04:54:55','2022-06-07 18:58:11','New York','Basil','Rochester',14604,8,74,4174049);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (81,'Krfjdlzqbezszy','3XL','2023-02-08 11:51:39','2023-03-04 06:13:59','Massachusetts','Waywood','Springfield',01114,47,83,8146768);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (82,'Ftyrtbdhdzevmp','XL','2022-05-26 01:54:11','2022-06-25 09:24:36','Ohio','Fisk','Cleveland',44197,8,17,7609487);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (83,'Fvugbgfwiqlyiw','XS','2022-05-07 13:27:55','2022-10-12 01:14:21','Louisiana','Wayridge','Baton Rouge',70810,2,37,1014862);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (84,'Iksdwrsyzrjzse','S','2022-08-29 08:10:49','2022-07-02 14:04:19','Pennsylvania','Rusk','Philadelphia',19104,43,93,8877730);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (85,'Xwqycjidxamdfk','XS','2022-06-10 04:35:43','2022-05-08 03:51:35','Texas','Fairview','El Paso',79916,81,43,7124955);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (86,'Spbgwfeocptqjp','M','2022-09-20 23:37:38','2022-06-08 08:28:35','Florida','Continental','Miami',33142,75,90,9443645);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (87,'Rnnwldtauopyxc','XL','2023-03-15 12:21:56','2022-07-26 21:16:49','Virginia','Kinsman','Norfolk',23520,46,7,4249393);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (88,'Lajgntlhnjwnda','XL','2022-11-21 21:15:32','2023-02-28 05:13:55','New York','Sunfield','New York City',10004,91,32,3446358);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (89,'Jqnfcgssaugurq','XS','2022-05-10 04:29:02','2022-09-28 12:36:58','California','Hudson','Pasadena',91199,98,41,84739);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (90,'Xbkzqyzxsdahcg','S','2022-06-18 01:19:12','2022-11-29 03:40:47','California','Debra','Los Angeles',90050,80,52,8606939);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (91,'Lsznhyyqjtwusa','XS','2022-04-16 20:24:35','2022-07-08 14:57:12','Florida','Crowley','Seminole',34642,91,3,6539965);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (92,'Lpsgzuuvtbkbkv','S','2022-07-09 00:53:26','2022-06-11 12:52:00','Ohio','Jenifer','Toledo',43699,14,41,4414666);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (93,'Ofubyotwmjwajj','XL','2022-12-17 23:06:28','2023-04-12 21:01:01','New York','Bellgrove','Staten Island',10305,69,34,385628);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (94,'Nqijzkcqoawwch','XL','2022-07-06 07:41:13','2022-07-01 16:17:36','Florida','Iowa','Pinellas Park',34665,23,85,1965667);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (95,'Iqgfpcpgkezaic','M','2022-05-16 05:47:41','2022-09-23 02:13:28','Texas','Erie','Fort Worth',76129,33,65,272220);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (96,'Hgxureivsycnoh','S','2022-07-23 06:12:10','2023-03-18 08:16:38','District of Columbia','Parkside','Washington',20525,66,88,5879982);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (97,'Gmdjpzzywmhlgk','XL','2022-09-02 04:54:49','2022-07-29 16:28:10','Texas','Kensington','Dallas',75260,31,15,6796970);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (98,'Cbubzwdfevwdqk','L','2022-04-16 11:14:34','2023-01-27 08:56:38','Texas','Artisan','El Paso',88546,96,22,22972);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (99,'Qaziztxjyksqfp','3XL','2023-03-22 11:13:26','2022-07-25 17:48:24','District of Columbia','Dixon','Washington',20337,8,40,4974134);
INSERT INTO Merchandise(item_number,item_description,available_sizes,date_last_restock,date_next_restock,supplier_state,supplier_street,supplier_city,supplier_zip_code,creator_id,supplier_id,total_in_stock) VALUES (100,'Sufzvdfoxiylna','3XL','2023-02-22 04:43:53','2022-10-05 09:50:52','California','Maryland','Santa Monica',90410,57,81,3359300);

INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (1,70,42,'Eirena Balmforth');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (2,69,24,'Verne Shuxsmith');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (3,54,56,'Osbourne Palser');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (4,87,95,'Carmencita Ramet');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (5,12,49,'Tymothy Element');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (6,6,95,'Carce Green');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (7,9,49,'Arlie Jacklin');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (8,89,86,'Leisha Heakey');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (9,7,78,'Conroy Clingan');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (10,99,97,'Dorella Dubber');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (11,31,20,'Cornie Lundberg');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (12,66,93,'Ginny Harte');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (13,76,56,'Caroljean Cissell');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (14,33,43,'Trey Dickman');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (15,41,4,'Kendal Costard');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (16,70,4,'Jermayne Boxell');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (17,62,38,'Mordy Rowney');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (18,17,60,'Cesar Brewitt');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (19,15,13,'Shelagh Kewley');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (20,33,88,'Eyde Speedy');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (21,51,41,'Shelli Dearlove');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (22,71,87,'Weber McGarvie');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (23,6,43,'Aubrey Yvon');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (24,87,61,'Dynah Twaits');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (25,79,89,'Cherye Kay');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (26,59,47,'Steffen Glastonbury');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (27,93,4,'Sigismondo Golland');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (28,94,24,'Magdalen Schubbert');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (29,24,43,'Stu MacCroary');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (30,51,89,'Shanda Dunkersley');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (31,74,81,'Joey Dingivan');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (32,68,20,'Alejoa Whittock');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (33,25,19,'Foster Houseley');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (34,3,33,'Marcos Stammers');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (35,83,27,'Al Pettit');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (36,50,37,'Gretchen Medcalfe');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (37,81,90,'Paquito Wych');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (38,22,95,'Anett Cornes');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (39,69,24,'Kathleen Waterworth');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (40,28,45,'Henri Glazebrook');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (41,7,49,'Cull Fumagallo');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (42,21,17,'Brande Bedinn');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (43,22,96,'Gilbertina Putton');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (44,82,31,'Elsworth Dimbylow');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (45,99,46,'Timofei Gritsunov');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (46,50,81,'Arie Volleth');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (47,49,49,'Grover Tetther');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (48,60,42,'Alleyn Summerbell');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (49,46,22,'Dyane Ferschke');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (50,65,83,'Florri Pitt');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (51,32,3,'Evania Ipplett');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (52,62,12,'Orlando Daveridge');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (53,60,48,'Concettina Meacher');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (54,69,100,'Ruth Wherton');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (55,83,10,'Leonard Griffoen');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (56,94,89,'Lola Cornill');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (57,29,49,'Catha Choat');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (58,6,84,'Marigold Norbury');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (59,10,41,'Gregg Moxstead');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (60,79,100,'Shanan Fahy');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (61,40,37,'Brigitta Dionisetto');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (62,81,36,'Gannie Clewes');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (63,82,76,'Dierdre Yuill');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (64,7,43,'Suzi Kibble');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (65,47,29,'Shena More');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (66,10,69,'Pepillo Greenside');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (67,42,66,'Butch Durber');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (68,1,43,'Domini Cambden');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (69,36,17,'Benjamen Gavey');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (70,59,29,'Mavra Bjerkan');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (71,83,38,'Leonhard Crichten');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (72,99,76,'Marie-jeanne Balding');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (73,42,66,'Milt Manwell');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (74,60,70,'Martha Longthorne');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (75,11,41,'Carolee Eyeington');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (76,53,98,'Callida Frend');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (77,98,40,'Mellisa Howett');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (78,4,71,'Noe Handrek');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (79,11,21,'Eugen Szymanzyk');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (80,96,32,'Hendrik Gai');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (81,35,45,'Benny Huniwall');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (82,31,32,'Ethelin Landis');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (83,4,62,'Dorey Paeckmeyer');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (84,5,74,'Malvin Daniello');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (85,41,77,'Julissa Holwell');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (86,6,29,'Hali Toor');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (87,10,96,'Kimbra Stable');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (88,86,15,'Fedora Atwool');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (89,67,92,'Tiebold Pahlsson');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (90,24,100,'Niall Rimer');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (91,99,1,'Maxy Spinks');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (92,33,34,'Hannis Sevier');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (93,36,3,'Augustina Goodread');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (94,63,91,'Alyss Janse');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (95,93,3,'Fedora Armour');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (96,17,22,'Rockwell Wais');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (97,21,76,'Alverta Bosanko');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (98,6,63,'Kristina Bish');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (99,68,92,'Madeline Luis');
INSERT INTO Orders(order_number,item_number,price,customer_name) VALUES (100,25,29,'Phillie Brandenberg');
