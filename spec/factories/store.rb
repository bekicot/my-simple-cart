FactoryBot.define do
  factory :store do
    name { Faker::App.name }
    description { Faker::Quote.yoda }
    address { Faker::Address.full_address }
  end
end
