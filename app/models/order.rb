class Order < ApplicationRecord

  belongs_to :invoice, optional: true
  belongs_to :user
  belongs_to :store
  belongs_to :courier
  has_many   :order_items

  before_save :set_total
  # after_create :remove_cart

  def self.checkout(user_id, checkout_params)
    # [{store_id: 1, items: [{product_variant_id: 2, quantity: 10, notes: 'test note'}, {product_variant_id: 3, quantity: 1, notes: 'test notes'}], courier: {id: 1, price: 10000}}]
    orders = []
    checkout_params.each do |checkout|
      store = Store.find checkout[:store_id]
      order = Order.where(user_id: user_id, store_id: store.id).first_or_initialize do |o|
        o.courier_id = checkout[:courier][:id]
        o.delivery_cost = checkout[:courier][:price]
        o.status = 1
      end
      checkout[:items].each do |item|
        product_variant = ProductVariant.find item[:product_variant_id]
        order_item = OrderItem.new(
          product_variant_id: item[:product_variant_id],
          price: product_variant.price,
          quantity: item[:quantity],
          discount: product_variant.discount,
          notes: item[:notes]
        )
        order.order_items << order_item
      end
      if order.valid?
        orders << order
      else
        return [false, order.errors]
      end
    end
    #create invoice and connect it to order
    invoice = Invoice.create(user_id: user_id, pay_status: 1, payment_type: 1)
    orders.map { |order| order.invoice_id = invoice.id; order.save; order.remove_cart}
    return true
  end

  private

  def set_total
    self.total_price = order_items.map{|a| a.total}.sum
    self.total = total_price+delivery_cost
  end

  def remove_cart
    cart = Cart.where(user_id: user_id, store_id: store_id).first
    cart.cart_items.where(product_variant_id: order_items.map(&:product_variant_id)).map(&:delete_with_parent_if_no_child)
  end

end
