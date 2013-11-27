require 'spec_helper'

describe Game do

  subject(:game) { Game.create(name: "New Game") }
  
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it { should have_many(:rounds) }
    it { should have_many(:tributes) }
    it { should have_many(:sponsors) }
  end

  describe "#new_game" do
    context "chosen tributes are assoicate with the current game" do
      it "has a game" do
        expect(district.reap[0].type).to eq("Tribute")
        expect(district.reap[1].type).to eq("Tribute")
      end
    end
  end

end