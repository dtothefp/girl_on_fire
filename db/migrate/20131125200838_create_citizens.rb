class CreateCitizens < ActiveRecord::Migration
  def change
    create_table :citizens do |t|
      t.string :name
      t.integer :age
      t.string :sex
      t.string :type, index: true
      t.boolean :alive, default: true
      t.references :district
      t.references :game

      t.timestamps
    end
  end
end
