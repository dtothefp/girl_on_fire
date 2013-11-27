FactoryGirl.define do
  factory :district do
    name { (1..12).to_a.push("Panem").sample.to_s }
  end
end