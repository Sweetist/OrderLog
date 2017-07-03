class AddDeliveryReferences < ActiveRecord::Migration[5.1]
  def change
      
      add_reference :deliveries, :bakery, foreign_key: true
      add_reference :deliveries, :recipient, foreign_key: true
      add_reference :deliveries, :order, foreign_key: true

  end
end
