class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :case_id
      t.string :doc_id
      t.string :type
      t.string :content

      t.timestamps
    end
  end
end
