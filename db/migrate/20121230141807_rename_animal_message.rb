class RenameAnimalMessage < ActiveRecord::Migration
  def up
    rename_table :animals_messages, :animals_notes
    change_table :animals_notes do |t|
      t.rename :message_id, :note_id
    end
  end

  def down
    change_table :animals_notes do |t|
      t.rename :note_id, :message_id
    end
    rename_table :animals_notes, :animals_messages
  end
end
