FactoryBot.define do
  factory :product_variant do
    product_id { 1 } 
    sku { "test-sku" }
    price { 11000 }
    quantity { 100 }
    discount { 10 }
  end
end