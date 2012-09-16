class AddMotherAndFatherToAnimal < ActiveRecord::Migration
  def change
    change_table :animals do |t|
      t.integer :mother
      t.integer :father
    end
  end
end