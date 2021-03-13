class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.references :user
      t.string :title
      t.text :description
      t.decimal :progress_rate, precision: 10, scale: 2
      t.timestamps
    end
  end
end
