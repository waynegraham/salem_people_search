class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :case_id
      t.integer :name_id

      t.timestamps
    end
  end
end
