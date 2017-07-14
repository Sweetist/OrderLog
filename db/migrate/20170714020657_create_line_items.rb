class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      
      t.integer :variant_id
      t.integer :quantity

      t.timestamps
    end
  end
end
