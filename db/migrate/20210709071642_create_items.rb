class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :user_id, null: false
      t.string :item_name, null: false
      t.integer :number, null: false, default: 1
      t.date :replacement
      t.string :item_memo

      t.timestamps
    end
  end
end
