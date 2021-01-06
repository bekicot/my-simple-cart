class ProductVariantDetail < ApplicationRecord

  belongs_to :product_variant
  belongs_to :variant_option
  belongs_to :variant

end
