class AddOwnerToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :owner_id, :integer
  end
end
