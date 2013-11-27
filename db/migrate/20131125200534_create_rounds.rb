class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :name
      t.integer :game_id

      t.timestamps
    end
  end
end
