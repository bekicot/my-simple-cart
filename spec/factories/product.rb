FactoryBot.define do
  factory :product do
    name { Faker::App.name }
    description { Faker::Quote.yoda }
  end
end
