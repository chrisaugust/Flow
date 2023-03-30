# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.create!([
{ name: "Food", budget: 400 },
{ name: "Housing", budget: 500 },
{ name: "Transportation", budget: 100 },
{ name: "Phone", budget: 80 },
{ name: "Education", budget: 200 },
{ name: "Household", budget: 50 },
{ name: "Clothes", budget: 25 },
{ name: "Books", budget: 80 },
{ name: "Eating Out", budget: 100 },
{ name: "Entertainment", budget: 25 },
{ name: "Credit Cards", budget: 100 },
{ name: "Loan Payments", budget: 100 }
])
