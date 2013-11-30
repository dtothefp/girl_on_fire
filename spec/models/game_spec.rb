require 'spec_helper'

describe Game do
  let(:panem) { District.create(name: "Panem") }
  subject(:game) { Game.create(name: "New Game") }
  
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it { should have_many(:rounds) }
    it { should have_many(:tributes) }
    it { should have_many(:sponsors) }
  end

  describe "find all of the tributes associated with a game" do
    context "returns all the tributes associated with the current game" do
      before do
        Citizen.destroy_all
        counter = 1
        12.times do
          Sponsor.create(name: "Sponsor " + counter.to_s, age: (40..60).to_a.sample, sex: ["f", "m"].sample, district: panem, game_id: game.id)
          counter += 1
        end
        counter = 1
        12.times do
          district = District.create(name: "District " + counter.to_s)
          Citizen.create(name: "Citizen" + counter.to_s + " f", age: (12..18).to_a.sample, sex: "f", district: district )
          Citizen.create(name: "Citizen" + counter.to_s + " m", age: (12..18).to_a.sample, sex: "m", district: district )
          @tributes = district.reap(game)
          @tribute1 = @tributes[0]
          @tribute2 = @tributes[1]
          @tribute1.get_rating
          @tribute2.get_rating
          @tribute1.get_sponsors
          @tribute2.get_sponsors
          counter += 1
        end
      end
      
      it "has tributes 24 tributes" do
        expect(game.tributes.count).to eq(24)
      end
    end
  end

end