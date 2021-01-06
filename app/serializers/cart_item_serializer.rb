class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :discount, :total, :notes, :product, :product_variant
  belongs_to :product_variant

  def product
    object.product_variant.product
  end

end
