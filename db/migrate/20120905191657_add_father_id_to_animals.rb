class AddFatherIdToAnimals < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.add :father_id, :mother_id, :integer
    end
  end
  
  def self.down
    change_table :animals do |t|
      t.remove :father_id, :mother_id
    end
  end
end
