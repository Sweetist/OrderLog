class Recipient < ApplicationRecord

  has_many :orders, dependent: :nullify

end