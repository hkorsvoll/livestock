class RenameMessageToNote < ActiveRecord::Migration
  def up
    rename_table :messages, :notes
  end

  def down
    rename_table :notes, :messages
  end
end
