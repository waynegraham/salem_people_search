class AddDocIdIndex < ActiveRecord::Migration
  def change
    add_index :cases, :doc_id
  end
end
