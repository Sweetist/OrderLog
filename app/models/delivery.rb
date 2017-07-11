class Delivery < ApplicationRecord
	belongs_to :bakery, optional: true
	belongs_to :order, optional: true
	belongs_to :recipient, optional: true


end