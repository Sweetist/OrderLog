class Order < ApplicationRecord

  has_many :deliveries, dependent: :nullify

end
