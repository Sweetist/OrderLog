class AddDeliveryReferences < ActiveRecord::Migration[5.1]
  def change
      
      add_reference :orders, :bakery, foreign_key: true
      add_reference :orders, :recipient, foreign_key: true

      add_reference :deliveries, :order, foreign_key: true  
  end
end