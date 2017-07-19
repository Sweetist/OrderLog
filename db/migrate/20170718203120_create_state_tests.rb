class CreateStateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :state_tests do |t|

      t.string :state

      t.timestamps
    end
  end
end
