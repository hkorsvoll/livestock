class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.text :message
      t.date :date_from
      t.date :date_to
      t.integer :category_id

      t.timestamps
    end
  end
  
  def down
    drop_table :messages
  end
end
