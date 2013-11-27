class CreateRoundsTributes < ActiveRecord::Migration
  def change
    create_table :rounds_tributes do |t|
      t.references :round
      t.references :tribute

      t.timestamps 
    end
  end
end
