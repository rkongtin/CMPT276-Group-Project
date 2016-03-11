# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#rake db:reset to reset the db
#rake db:seed to set up db with blow things

User.create(name: 'FirstAdmin', email: 'admin@sfu.ca', password: 'administration', admin: 'true')
User.create(name: 'test', email: 'test@sfu.ca', password: 'tester', admin: 'false')
User.create(name: 'test2', email: 'test2@sfu.ca', password: 'tester', admin: 'false')