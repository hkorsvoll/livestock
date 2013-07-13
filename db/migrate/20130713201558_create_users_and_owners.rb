class CreateUsersAndOwners < ActiveRecord::Migration
  def change
    remove_column :users, :owner_id
    create_table :owners_users do |table|
      table.belongs_to :owner, :null => false
      table.belongs_to :user, :null => false
    end
  end

end
