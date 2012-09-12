class AddFatherIdToAnimals < ActiveRecord::Migration
  def change
    change_table :animals do |t|
      t.integer :father_id
    end
  end
end
