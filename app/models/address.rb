class Address < ApplicationRecord

	has_many :bakery, dependent: :nullify
	has_many :recipients, dependent: :nullify
	belongs_to :state, optional: true
	belongs_to :country, optional: true

	def toString
		addressString=""
		addressString+=address1 unless address1.nil?
		addressString+=" "+address2 unless address2.nil?
		addressString+=", "+city unless city.nil?
		addressString+=", "+state.name unless state.nil?
		addressString+=", "+country.name unless country.nil?
		addressString+=" "+zipcode unless zipcode.nil?
		addressString
	end

end