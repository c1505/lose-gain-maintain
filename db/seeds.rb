# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
pounds = 175.0
date = Time.now
User.create(email: "email@email.com", password: "password")
20.times do
  pounds = pounds += rand(-0.3..0.5)
  date = date - 1.day
  Weight.create(pounds: pounds, date: date, user_id: 1 )
end

pounds = 160.0
User.create(email: "user2@email.com", password: "password")
20.times do
  pounds = pounds += rand(-0.3..0.5)
  date = date - 1.day
  Weight.create(pounds: pounds, date: date, user_id: 2 )
end