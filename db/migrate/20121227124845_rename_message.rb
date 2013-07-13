class RenameMessage < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.rename :message, :content
    end
  end
end
