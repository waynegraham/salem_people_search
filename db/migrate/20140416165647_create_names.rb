class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :key
      t.string :name

      t.timestamps
    end
  end
end
