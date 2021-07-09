class CreateShelters < ActiveRecord::Migration[5.2]
  def change
    create_table :shelters do |t|
      t.integer :user_id, null: false
      t.string :shelter_name, null: false
      t.string :address, null: false
      t.string :shelter_memo
      
      t.timestamps
    end
  end
end
