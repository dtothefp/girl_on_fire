FactoryGirl.define do
  factory :game do
    name { "Game" + (1..10).to_a.sample.to_s }
  end
end