class Bakery < ApplicationRecord

  has_many :orders, dependent: :nullify
  has_one :address, dependent: :nullify

end