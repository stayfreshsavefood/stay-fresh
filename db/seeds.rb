require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning DB users, ingredients and fridge"
Recipe.destroy_all
ExpiryNotification.destroy_all
InviteNotification.destroy_all
Ingredient.destroy_all
FridgeUser.destroy_all
User.destroy_all
Fridge.destroy_all

puts "Creating three user"

user = User.new(username: 'kaviya', email: 'test@mail.com', password: "123456" )
user.save
fridge = Fridge.new(name: 'My Fridge')
fridge.save
fridge_user = FridgeUser.new
fridge_user.user = user
fridge_user.fridge = fridge
fridge_user.save
puts fridge_user.user.username
puts fridge_user.fridge.name
# puts fridge.users
10.times do
  ingredient = Ingredient.new(name: Faker::Food.vegetables, category: "Fruits & Veggies", exp_date: Faker::Date.between(from:  Date.today, to: '2022-06-05'), quantity: rand(10), unit:"piece")
  ingredient.fridge = fridge
  ingredient.save
end

user = User.new(username: 'Natalia', email: 'test2@mail.com', password: "123456" )
user.save
fridge = Fridge.new(name: 'My Fridge')
fridge.save
fridge_user = FridgeUser.new
fridge_user.user = user
fridge_user.fridge = fridge
fridge_user.save
puts fridge_user.user.username
puts fridge_user.fridge.name

3.times do
  user = User.new(username: Faker::Name.unique.name, email: Faker::Internet.email, password: "123456" )
  user.save
  fridge = Fridge.new(name: Faker::Color.color_name)
  fridge.save
  fridge_user = FridgeUser.new
  fridge_user.user = user
  fridge_user.fridge = fridge
  fridge_user.save
  puts fridge_user.user.username
  puts fridge_user.fridge.name
  # puts fridge.users
  10.times do
    ingredient = Ingredient.new(name: Faker::Food.vegetables, category: "Fruits & Veggies", exp_date: Faker::Date.between(from:  Date.today, to: '2022-06-05'), quantity: rand(10), unit:"piece")
    ingredient.fridge = fridge
    ingredient.save
  end
end
