class CreateMatings < ActiveRecord::Migration
  def change
    create_table :matings do |t|
      t.integer :animal_id
      t.date :mating_date
      t.integer :uncertainty

      t.timestamps
    end
    add_index :matings, [:animal_id]
  end
end
