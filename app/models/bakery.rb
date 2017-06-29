class Bakery < ApplicationRecord

  has_many :deliveries, dependent: :nullify

end
