FactoryBot.define do
  factory :order do
    total_price { 10000 } 
    delivery_cost { 1000 }
    total { 11000 }
    status { 1 }
    user_id { 1 }
    store_id { 1 }
    courier_id { 1 } 
  end
end