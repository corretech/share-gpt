# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email:"jugglego32391731@gmail.com", password:ENV["USER_PASSWORD"], password_confirmation: ENV["USER_PASSWORD"])
Room.create(user_id:1)
Chat.create(room_id:1, user_id:1)