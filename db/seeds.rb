# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
UserAdmin.create(name: "Nitesh", email: "dummy@flight.com", password: "dummy123")
5.times do
	Airplane.create!(
		name: Faker::Name.name,
		seats: Faker::Number.number(digits: 2),
		category: "Buisness",
		rows: Faker::Number.number(digits: 1),
		source: Faker::Address.state_abbr,
		destination: Faker::Address.state_abbr,
		price: Faker::Number.decimal(l_digits: 4, r_digits: 3)
		)
end