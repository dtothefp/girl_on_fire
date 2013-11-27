class AddRatingToCitizens < ActiveRecord::Migration
  def change

    add_column :citizens, :rating, :integer, default: nil
  end
end
