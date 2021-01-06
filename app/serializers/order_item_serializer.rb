class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :discount, :total, :notes, :product, :product_variant, :variant_name
  
  belongs_to :product_variant

  def product
    object.product_variant.product
  end

  def variant_name
    "#{object.product_variant.product_variant_details.map(&:variant_option).map(&:name).join('-')}"
  end
  
end
