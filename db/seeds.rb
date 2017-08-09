# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'  

def arr_to_hash(model, arr)
	new_hash = {}
	model.column_names.each_with_index do |col, ind|
		new_hash[col] = arr[ind]
	end
	new_hash
	puts new_hash
end

csv_text = File.read('state.csv')
csv = CSV.parse(csv_text, :headers => false)
csv.each do |row|
	State.create!(arr_to_hash(State, row))
end

csv_text = File.read('country.csv')
csv = CSV.parse(csv_text, :headers => false)
csv.each do |row|
	State.create!(arr_to_hash(Country, row))
end
