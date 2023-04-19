# Podify: MySQL + Flask Project

## Created by Angela Weigl, Natalie Costa, Ray Valenzuela, Ky Wong for CS 3200 with Mark Fontenot

Podify is a podcast app built for listeners and creators to share and enjoy audio content. Listeners have the ability to create, edit, and delete playlists, view creator profiles, and more. Creators have the ability to post and delete podcast episodes and pocasts, sell merchandise, and more. Podify's main goal is to lessen the time and effort it normally takes to find a good podcast to listen to, and serves as an all-in-one hub for interactions between listeners and creators.

## Link to demo video: 
https://drive.google.com/file/d/1BUnex5Xkmx5XGUnqDl3M8i5KhHZfZ2XL/view?usp=sharing 

## How to setup and start the containers

1. Install Docker Desktop before running project.
1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 
