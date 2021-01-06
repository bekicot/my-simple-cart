FactoryBot.define do
  factory :invoice do
    pay_at { Time.current }
    pay_status { 1 }
  end
end
