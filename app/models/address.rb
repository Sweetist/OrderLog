class Address < ApplicationRecord

	belongs_to :bakery, optional: true
	belongs_to :recipient, optional: true

	def toString
		addressString=""
		addressString+=address1 unless address1.nil?
		addressString+=" "+address2 unless address2.nil?
		addressString+=", "+city unless city.nil?
		addressString+=" "+zipcode unless zipcode.nil?
		addressString
	end

end