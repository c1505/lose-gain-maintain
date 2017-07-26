# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
pounds = 175.0
date = Time.now - 1.month

20.times do
  pounds = pounds += 0.1
  date = date + 1.day
  Weight.create(pounds: pounds, date: date )
end