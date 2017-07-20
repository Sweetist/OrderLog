class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      
      t.integer :delivery_number
      t.date :date
      t.time :scheduled_collection
      t.time :scheduled_delivery
      t.time :pickup_time
      t.time :dropoff_time
      t.boolean :is_on_time
      t.string :courier_service
      t.float :courier_fee
      t.string :address
      t.string :notes

      t.string :state

      #t.integer :lock_version, default: 0, null: false
      
      t.timestamps
    end

    add_index :deliveries, :delivery_number, unique: true
  end
end
