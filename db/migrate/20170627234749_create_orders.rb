class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :number
      t.date :date
      
      t.float :subtotal
      t.float :commission
      t.float :subtotal_without_commmission
      t.float :tax
      t.float :delivery_fee
      t.float :service_charge
      t.float :revenue
      t.float :promotions
      
      t.timestamps
    end

    add_index :orders, :order, unique: true
  end
end
