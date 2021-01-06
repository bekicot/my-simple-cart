class CartItem < ApplicationRecord

  belongs_to :cart
  belongs_to :product_variant

  validates :quantity, :price, :discount, :total, presence: true
  validate :valid_stock?

  before_save :set_total

  def delete_with_parent_if_no_child
    parent = self.cart
    self.destroy
    parent.destroy unless CartItem.where(cart_id: parent.id).exists?
  end

  private

  def valid_stock?
    errors.add(:quantity, "product is out of stock") if product_variant.quantity.to_i < quantity.to_i
  end

  def set_total
    self.total = quantity*(price-(price * discount/100))
  end

end
