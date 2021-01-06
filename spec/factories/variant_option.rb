FactoryBot.define do
  factory :variant_option do
    name { Faker::Name.name }
    variant_id { 1 }
  end
end
