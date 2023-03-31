# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.create!([
{ name: "Food",
    description: "Groceries, eating out, snacks..." },
{ name: "Housing" },
{ name: "Transportation" },
{ name: "Essential Bills",
    description: "Utilities, phone, internet, etc." },
{ name: "Health/Medical" },
{ name: "Insurance" },
{ name: "Personal Care",
    description: "Personal hygiene products, clothes/shoes,
    haircuts, etc." },
{ name: "Children" },
{ name: "Pets" },
{ name: "Savings" },
{ name: "Debt" },
{ name: "Education/Personal Development" },
{ name: "Entertainment",
    description: "Going out with friends, movies, subscriptions, memberships,
    music events, hobbies..." },
{ name: "Gifts" },
{ name: "Vices",
    description: "Caffeine, Nicotine, Alcohol, and dare I say... Drugs!" }
])

User.create!([
{ name: "admin",
  email: "admin@example.com",
  password: "secret",
  password_confirmation: "secret",
  admin: true }
])
