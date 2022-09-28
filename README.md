Sweater Weather API

![Screen Shot 2022-09-28 at 2 33 42 AM](https://user-images.githubusercontent.com/90064385/192705236-6da1eccb-86a4-4640-beb4-92484d0de04e.png)

Sweater Weather is an API built with Ruby on Rails used to create/authenticate and store users securley, as well as provide weather, location, and directional data to the front-end to display to any and all users

Table of Contents
- [Getting Started](#getting_started)
- [API Endpoints](#api_endpoint)
- [User Endpoints](#user_endpoints)
- [Weather Endpoints](#weather_endpoints)
- [Local Hosting](#local_hosting)
- [Prerequisites](#Prerequisites)
- [Installation](#Installation)

Getting Started
Thanks for checking out Sweater Weather! There are a few ways to access and manipulate data through our API endpoints and a few technologies we used to develop our project.


API Endpoints

Users Endpoints
post /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
Creates a user
post /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
 "email": "whatever@example.com",
 "password": "password"
}
Logs in a user

Weather Endpoints
get /api/v1/forecast?location='city,state'
Gets weather for a city
post /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
Creates a road trip

Local Hosting
In order to host this API locally you will need to configure your development environment appropriately.


Prerequisites
Sweater Weather was developed in Rails 5.2.8.1 (it is recommended to use either this version or a newer version of rails within Rails 5) and Ruby version 2.7.4.

To verify your version of Ruby and Rails run the following commands from your command line:

$ ruby -v
$ ruby 2.7.4p191 (2021-07-07 revision a21a3b7d23) [arm64-darwin21]
$ rails -v
$ Rails 5.2.8.1
If you do not have Ruby installed please visit the Ruby docs here.

If you also need Rails please visit the Rails documentation site here.


Installation
Open your terminal and run these commands:

gem install bundler
git clone https://github.com/z-prince/sweater_weather
bundle install
rails db:{drop,create,migrate,seed}
Due to the fact that this will be a local consumption, all endpoints you consume will start with http://localhost:3000 by default unless specified otherwise.

Now that everything is properly configured on your local machine, run rails s in your terminal to start the server and get consuming!
