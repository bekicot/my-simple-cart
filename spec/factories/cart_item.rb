FactoryBot.define do
  factory :cart_item do
    cart_id {1}
    product_variant_id { 1 }
    quantity { 1 }
    price { 1 }
    discount { 1 }
    total { 1 }
    notes {'test notes'}
  end
end
      