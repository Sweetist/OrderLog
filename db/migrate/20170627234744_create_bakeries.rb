class CreateBakeries < ActiveRecord::Migration[5.1]
  def change
    create_table :bakeries do |t|
      t.string :name
      t.string :bakery_type
	  #t.string :address      
      t.timestamps
    end

    add_index :bakeries, :name, unique: true
  end
end