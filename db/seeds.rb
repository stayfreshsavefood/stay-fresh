require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning DB users, ingredients and fridge"
InviteNotification.delete_all
FridgeUser.delete_all
User.delete_all
Ingredient.delete_all
Fridge.delete_all

puts "Creating three user"

3.times do
  user = User.new(username: Faker::Name.unique.name, email: Faker::Internet.email, password: "123456" )
  user.save
  fridge = Fridge.new(name: Faker::Color.color_name)
  fridge.save
  fridge_user = FridgeUser.new
  fridge_user.user = user
  fridge_user.fridge = fridge
  puts fridge_user.user.id
  puts fridge_user.fridge.id
  # puts fridge.users
  10.times do
    ingredient = Ingredient.new(name: Faker::Food.vegetables, category: "vegetable", exp_date: Faker::Date.between(from:  Date.today, to: '2022-06-05'), quantity: rand(10), unit:"piece")
    ingredient.fridge = fridge
    ingredient.save
  end
end
