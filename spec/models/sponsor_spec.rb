require 'spec_helper'

describe Sponsor do
  let(:game) { Game.create(name: "Game 1") }
  let(:district) { District.create(name: "District 1") }

  subject(:sponsor) { Sponsor.new(name: "Tribute 1", age: 18, sex: "m", district: district, game: game) }

  describe "validations" do
    it { should validate_presence_of(:district_id) }
    it { should validate_presence_of(:game_id) }

    it { should belong_to(:game) }
    it { should have_many(:sponsorships) }
    it { should have_many(:tributes).through(:sponsorships) }
  end


end