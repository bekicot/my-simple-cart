class ProductVariantSerializer < ActiveModel::Serializer
  attributes :id, :sku, :price, :quantity, :discount, :variant_name

  belongs_to :product
  has_many :product_variant_details, serializer: ProductVariantDetailSerializer

  def variant_name
    "#{object.product_variant_details.map(&:variant_option).map(&:name).join('-')}"
  end

end
