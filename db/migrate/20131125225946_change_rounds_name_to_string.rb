class ChangeRoundsNameToString < ActiveRecord::Migration
  def change
    change_column :rounds, :name, :string
  end
end
