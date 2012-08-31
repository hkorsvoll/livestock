class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.string :id_tag
      t.date :birth_date
      t.date :death_date
      t.enum :sex

      t.timestamps
    end
  end
end
