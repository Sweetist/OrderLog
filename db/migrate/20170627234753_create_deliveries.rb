class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.integer :delivery_number
      t.date :week
      t.date :date
      t.string :weekday
      t.time :scheduled_collection
      t.time :scheduled_delivery
      t.time :pickup_time
      t.time :dropoff_time
      t.boolean :is_on_time
      t.string :courier_service
      t.float :courier_fee

      t.string :notes
      
      t.references :bakery, foreign_key: true
      t.references :recipient, foreign_key: true
      t.references :order, foreign_key: true
      
      t.timestamps
    end
  end
end
