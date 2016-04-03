# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#rake db:reset to reset the db
#rake db:seed to set up db with blow things

User.create(name: 'FirstAdmin', email: 'admin@sfu.ca', password: 'administration', admin: 'true', pictures: "http://cdn.myanimelist.net/images/characters/3/243573.jpg")
User.create(name: 'test', email: 'test@sfu.ca', password: 'tester', admin: 'false', pictures: "http://orig00.deviantart.net/f31f/f/2015/068/4/5/profile_picture_by_kotatux-d8l11ni.png")
User.create(name: 'test2', email: 'test2@sfu.ca', password: 'tester', admin: 'false', pictures: "http://assets2.ignimgs.com/2015/12/12/toarukagakunorailguns-19-febri-meatball-eating-cute-comedy-adorablejpg-19ba09_1280w.jpg")