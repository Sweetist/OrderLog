class Order < ApplicationRecord
  
  has_many :line_items, dependent: :nullify
  has_many :deliveries, dependent: :nullify
  belongs_to :bakery, optional: true
  belongs_to :recipient, optional: true


end