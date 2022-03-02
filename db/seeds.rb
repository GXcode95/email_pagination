# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

100.times do
  Email.create!(object: Faker::Lorem.sentence,
               content: Faker::Lorem.paragraph(sentence_count: 20),
               recipient: "test@test.test",
               sender: Faker::Internet.email)
end

100.times do
  Email.create!(object: Faker::Lorem.sentence,
               content: Faker::Lorem.paragraph(sentence_count: 20),
               recipient: Faker::Internet.email,
               sender: "test@test.test")
end

User.create(email: "test@test.test", password: "123456")