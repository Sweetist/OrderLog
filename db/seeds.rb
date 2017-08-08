# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

YAML.load_file("db/statedata.yml").each do |state|
	state[1]["records"].each do |record|
		ar = {}
		state[1]["columns"].each_with_index do |col, ind|
			ar[col] = record[ind]
		end
		s = State.create!(ar)
		s.save
	end
end

YAML.load_file("db/countrydata.yml").each do |country|
	country[1]["records"].each do |record|
		ar = {}
		country[1]["columns"].each_with_index do |col, ind|
			ar[col] = record[ind]
		end
		s = Country.create!(ar)
		s.save
	end
end