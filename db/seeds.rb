# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# create random users
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: "coucou"
  )
end
puts "*" * 20
puts "Users"
tp User.all

# create random articles
35.times do
  Article.create!(
    user_id: User.all.sample.id,
    title: Faker::TvShows::Community.characters,
    content: Faker::TvShows::Community.quotes
  )
end
puts "*" * 20
puts "Articles"
tp Article.all