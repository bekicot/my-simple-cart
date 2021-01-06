class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :product_variant

  validates :quantity, :price, :discount, :total, presence: true
  validate :valid_stock?, :valid_product_variant_in_store

  before_validation :set_total

  private

  def valid_stock?
    errors.add(:quantity, "product is out of stock") if product_variant && product_variant.quantity.to_i < quantity.to_i
  end

  def valid_product_variant_in_store
    errors.add(:product_variant_id, "could not find record product variant id #{product_variant_id} in store id #{order.store_id}") if product_variant && order && product_variant.product.store_id != order.store_id
  end

  def set_total
    self.total = quantity.to_i*(price.to_f-(price.to_f * discount.to_f/100))
  end

end
