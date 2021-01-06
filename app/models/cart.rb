class Cart < ApplicationRecord

  belongs_to :user
  belongs_to :store
  has_many :cart_items

  def self.add_product(user, product_variant, quantity, notes)
    product = product_variant.product
    cart = Cart.where(user_id: user.id, store_id: product.store_id).first_or_initialize
    cart_item = cart.cart_items.where(product_variant_id: product_variant.id).first_or_initialize
    cart_item.product_variant_id = product_variant.id
    cart_item.quantity = cart_item.quantity.to_i + quantity.to_i
    cart_item.price = product_variant.price
    cart_item.discount = product_variant.discount
    cart_item.total = cart_item.quantity.to_i * (product_variant.price - (product_variant.price*(product_variant.discount.to_f/100)))
    cart_item.notes = notes.to_s
    if cart_item.save
      return true
    else
      return [false, cart_item.errors]
    end
  end

  def delete_me_if_no_item
    self.destroy unless CartItem.where(cart_id: self.id).exists?
  end
  
end
