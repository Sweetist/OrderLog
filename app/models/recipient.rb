class Recipient < ApplicationRecord

  has_many :recipients, dependent: :nullify

end