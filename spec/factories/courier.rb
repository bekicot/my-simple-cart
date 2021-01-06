FactoryBot.define do
  factory :courier do
    name { Faker::App.name }
    price { 1000 }
  end
end
