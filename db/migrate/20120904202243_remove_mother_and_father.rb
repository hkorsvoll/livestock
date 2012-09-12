class RemoveMotherAndFather < ActiveRecord::Migration
  def change
    rename_column :animals, :mother, :mother_id
    remove_column :animals, :father, :father_id
  end
end


