class CreateStatesAndCountries < ActiveRecord::Migration[5.1]
  def change
  	create_table "states", force: :cascade do |t|
      t.string   "name"
      t.string   "abbr"
      t.datetime "updated_at"
  	end

  	create_table "countries", force: :cascade do |t|
      t.string   "iso_name"
      t.string   "iso"
      t.string   "iso3"
      t.string   "name"
      t.integer  "numcode"
      t.boolean  "states_required", default: false
      t.datetime "updated_at"
  	end
		
	  add_reference :addresses, :state, foreign_key: true
	  add_reference :addresses, :country, foreign_key: true
	  add_reference :states, :country, foreign_key: true
  end
end
