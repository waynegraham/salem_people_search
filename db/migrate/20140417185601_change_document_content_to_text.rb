class ChangeDocumentContentToText < ActiveRecord::Migration
  def change
    change_column(:cases, :content, :text)
  end
end
