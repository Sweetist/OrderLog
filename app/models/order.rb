class Order < ApplicationRecord
  
  has_many :line_items, dependent: :nullify
  has_many :deliveries, dependent: :nullify

end