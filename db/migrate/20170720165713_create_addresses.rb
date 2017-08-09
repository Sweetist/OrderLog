class CreateAddresses < ActiveRecord::Migration[5.1]
	def change
		create_table :addresses do |t|
			t.string   "firstname",             limit: 255
			t.string   "lastname",              limit: 255
			t.string   "address1",              limit: 255
			t.string   "address2",              limit: 255
			t.string   "city",                  limit: 255
			t.string   "zipcode",               limit: 255
			t.string   "phone",                 limit: 255
			t.string   "state_name",            limit: 255
			t.string   "alternative_phone",     limit: 255
			t.string   "company",               limit: 255
			t.datetime "created_at"
			t.datetime "updated_at"
			t.text     "delivery_instructions"
			t.timestamps
		end
		add_reference :addresses, :bakery, foreign_key: true
		add_reference :addresses, :recipient, foreign_key: true
		add_reference :bakeries, :address, foreign_key: true
		add_reference :recipients, :address, foreign_key: true
		#add_reference :addresses, :user, foreign_key: true
	end
end
