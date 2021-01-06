FactoryBot.define do
  factory :order_item do
    order_id { 1 }
    product_variant_id { 1 } 
    quantity { 1 } 
    price { 10000 }
    discount { 0 }
    total { 0 }
    notes { "test note" }
  end
end
