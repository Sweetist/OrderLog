class CreateRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      #t.string :address
      
      t.timestamps
    end

    add_index :recipients, :first_name
    add_index :recipients, :last_name
  end
end