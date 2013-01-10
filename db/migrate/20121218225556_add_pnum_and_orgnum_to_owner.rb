class AddPnumAndOrgnumToOwner < ActiveRecord::Migration
  def change
    add_column :owners, :pnum, :string
    add_column :owners, :orgnum, :string
  end
end
