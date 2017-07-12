class Bakery < ApplicationRecord

  has_many :orders, dependent: :nullify

end