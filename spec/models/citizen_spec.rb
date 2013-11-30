require 'spec_helper'

describe Citizen do
  let(:game) { Game.create(name: "Game 1") }
  let(:district) { District.create(name: "District 1") }

  subject(:citizen) { Citizen.new(name: "Citizen 1", age: 20, sex: "M", district: district) }

  describe "validations" do
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:sex) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:district_id) }

    it { should belong_to(:district) }
  end

  describe "#same_name_and_district" do
    context "the citizen has the same name in the same district" do
      before do
        saved_citizen = FactoryGirl.create(:citizen, district: district)
        saved_citizen.name = "Citizen 1"
        saved_citizen.save
      end
      it "is not valid" do
        expect(citizen).to have(1).errors_on(:name)
      end
    end
  end

    ## this is weird because the rating method has to be defined in the citizen model
  describe "#get_rating" do
    context "tributes gain a random rating" do
      before do
       counter = 1
        20.times do
          FactoryGirl.create(:citizen, name: "Citizen " + counter.to_s, age: (12..20).to_a.sample, district: district )
          counter += 1
        end
        @tributes = district.reap(game)
        @tribute1 = @tributes[0]
        @tribute2 = @tributes[1]
        # binding.pry
      end
      it "has a rating" do
        expect(@tribute1.get_rating).not_to eq(nil)
        expect(@tribute2.get_rating).not_to eq(nil)
      end
    end
  end

  describe "#get_sponsors" do
    context "a tribute has at least one sponsor" do
      before do
       counter = 1
        20.times do
          FactoryGirl.create(:citizen, name: "Citizen " + counter.to_s, age: (12..20).to_a.sample, district: district )
          counter += 1
        end
        20.times do
          FactoryGirl.create(:citizen, name: "Citizen " + counter.to_s, age: (30..60).to_a.sample, district: district, type: "Sponsor", game_id: game.id )
          counter += 1
        end
        tributes = district.reap(game)
        @tribute1 = tributes[0]
        @tribute2 = tributes[1]
        @tribute1.get_rating
        @tribute2.get_rating
      end
      it "has a sponsor" do
        # binding.pry
        expect(@tribute1.get_sponsors.count).to be >= 1
        expect(@tribute2.get_sponsors.count).to be >= 1
      end
    end
  end
  
end