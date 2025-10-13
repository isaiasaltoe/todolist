class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :tittle
      t.text :body
      t.integer :weight

      t.timestamps
    end
  end
end
