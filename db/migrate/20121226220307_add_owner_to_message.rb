class AddOwnerToMessage < ActiveRecord::Migration
  def change
    add_column :notes, :owner_id, :integer
  end
end
