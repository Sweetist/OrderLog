class Recipient < ApplicationRecord

  has_many :orders, dependent: :nullify
  belongs_to :address, optional: true

end