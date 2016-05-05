# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Xavier Fernandes",
             email: "xavier.c.f@hotmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  description = Faker::Lorem.sentences(6)
  sample_name = "this is a fake project"
  users.each { |user| user.projects.create!(name: sample_name, description: description) }
end

projects = Project.all
20.times do
  description = Faker::Lorem.sentence(5)
  projects.each{ |project| project.requirements.create!(description: description)}
end

projects2 = Project.all
names = ["los bananas","los bandidos","los scrum maestros","los hombres barigudos ","los mariachis",
          "los nachos", "los mustachios", "los hombres sin bigotes","los de la Uminho"]
5.times do
  projects2.each{ |project| project.teams.create!(name: names.sample)}
end
