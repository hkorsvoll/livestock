class AddProdnumToOwner < ActiveRecord::Migration
  def change
    add_column :owners, :prodnum, :string
  end
end
