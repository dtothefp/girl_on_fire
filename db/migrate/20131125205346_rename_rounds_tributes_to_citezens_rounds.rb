class RenameRoundsTributesToCitezensRounds < ActiveRecord::Migration
  def change
    rename_table :rounds_tributes, :citizens_rounds
  end
end
