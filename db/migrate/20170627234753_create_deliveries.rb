class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      
      t.integer :delivery_number
      t.datetime :fulfillment_date
      t.time :fulfillment_time
      t.time :pickup_time
      t.time :dropoff_time
      t.boolean :is_on_time
      t.string :courier_service
      t.float :courier_fee
      t.string :notes

      t.string :state
      
      t.timestamps
    end

    add_index :deliveries, :delivery_number, unique: true
  end
end
