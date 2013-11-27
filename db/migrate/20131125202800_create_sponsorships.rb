class CreateSponsorships < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.references :sponsor
      t.references :tribute

      t.timestamps
    end
  end
end
