class Country < ApplicationRecord

	has_many :addresses, dependent: :nullify

end