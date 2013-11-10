class AddMaleToMatings < ActiveRecord::Migration
  def change
    add_column :matings, :male_id, :integer
  end
end
