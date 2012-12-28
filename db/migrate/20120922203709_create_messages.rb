class CreateMessages < ActiveRecord::Migration
  def up
    create_table :notes do |t|
      t.text :note
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
