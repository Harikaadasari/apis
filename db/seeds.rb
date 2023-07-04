# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# db/seeds.rb
require 'faker'

10.times do
  project = Project.create(name: Faker::App.name)

  5.times do
    collection = project.collections.create(name: Faker::App.name)

    10.times do
      collection.apis.create(
        name: Faker::App.name,
        method: ['GET', 'POST', 'PUT', 'DELETE'].sample,
        path: Faker::Internet.url,
        requestheader: Faker::Lorem.sentence,
        requestbody: Faker::Lorem.paragraph
      )
    end
  end
end
