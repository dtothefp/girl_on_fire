require 'spec_helper'

describe Round do
  let(:game) { FactoryGirl.create(:game) }
  let(:panem) { District.create(name: "Panem") }
  subject(:round) { Round.new(name: "First Round", game: game) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:game_id) }

    it { should belong_to(:game) }
    it { should have_and_belong_to_many(:tributes) }
  end

  describe "#rounds_per_game" do
    context "rounds associated with the same game have identical names" do
      before do
        FactoryGirl.create(:round, name: "First Round", game: game)
      end
      it "is not valid" do
        expect(round).to have(1).errors_on(:name)
      end
    end
    context "a maximum of 3 rounds can be associated with one game" do
      before do
        Round.destroy_all
        counter = 1
        3.times do 
          Round.create(name: "Round " + counter.to_s,  game: game)
          counter += 1
        end
      end
      it "is not valid" do
        expect(round).to have(1).errors_on(:game_id)
      end
    end
  end

  describe "#fight" do
    context "tributes fight to the death" do
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
      it "2 tributes randomly fight and 1 survives" do
        expect(round.fight.length).to eq(game.tributes.count)
      end
    end
  end

end