class AddFatherIdToAnimals < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.add_column :father_id, :mother_id, :integer
    end
  end
  
  def self.down
    change_table :animals do |t|
      t.remove_column :father_id, :mother_id
end
