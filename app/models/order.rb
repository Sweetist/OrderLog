class Order < ApplicationRecord

	has_many :line_items, dependent: :nullify
	has_one :delivery, dependent: :nullify
	belongs_to :bakery, optional: true
	belongs_to :recipient, optional: true

	after_create :create_delivery

	def create_delivery
		self.build_delivery({})
	end

end