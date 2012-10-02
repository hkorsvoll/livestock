class CreateAnimalmessages < ActiveRecord::Migration
  def up
    create_table :animals_messages do |t|
      t.integer :animal_id
      t.integer :message_id
    end
  end

  def down
    drop_table :animals_messages
  end
end
