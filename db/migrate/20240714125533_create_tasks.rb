class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.text :details
      t.integer :category_id

      t.timestamps
    end
  end
end
