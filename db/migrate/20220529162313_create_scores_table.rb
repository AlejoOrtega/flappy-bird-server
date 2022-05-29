class CreateScoresTable < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :score
      t.timestamps
    end
  end
end
