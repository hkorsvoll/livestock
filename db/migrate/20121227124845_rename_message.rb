class RenameMessage < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.rename :note, :content
    end
  end
end
