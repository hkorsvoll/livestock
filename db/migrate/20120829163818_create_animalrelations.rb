class CreateAnimalrelations < ActiveRecord::Migration
  def change
    create_table :animalrelations do |t|
      t.integer	:animal_id
      t.integer	:parent_id
      t.enum	:relation_type
      t.timestamps
    end
  end
end
