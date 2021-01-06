class ProductVariant < ApplicationRecord

  belongs_to :product
  has_many :product_variant_details

  validates :sku, :price, :quantity, presence: true

  def variant_name
    product_variant_details.map(&:variant_option).map(&:name).join("-")
  end
  
end
